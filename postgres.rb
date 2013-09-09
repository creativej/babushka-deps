# dep 'existing postgres db', :username, :db_name do
#   requires 'postgres access'.with(:username => username)
#   met? {
#     !shell("psql -l") {|shell|
#       shell.stdout.split("\n").grep(/^\s*#{db_name}\s+\|/)
#     }.empty?
#   }
#   meet {
#     shell "createdb -O '#{username}' '#{db_name}'"
#   }
# end

# dep 'existing data', :username, :db_name do
#   requires 'existing postgres db'.with(username, db_name)
#   met? {
#     shell("psql #{db_name} -c '\\d'").scan(/\((\d+) rows?\)/).flatten.first.tap {|rows|
#       if rows && rows.to_i > 0
#         log "There are already #{rows} tables."
#       else
#         unmeetable! <<-MSG
# The '#{db_name}' database is empty. Load a database dump with:
# $ cat #{db_name}.psql | ssh #{username}@#{shell('hostname -f')} 'psql #{db_name}'
#         MSG
#       end
#     }
#   }
# end

dep 'pg.gem' do
  requires \
    'pg',
    'postgres access'.with('deployer', 'deployer', '-SdR'),
    'postgres access'.with('vagrant', 'vagrant', '-SdR')
end

dep 'postgres access', :username, :password, :flags do
  requires 'pg'
  requires 'user exists'.with(:username => username)
  username.default(shell('whoami'))
  flags.default!('-SdR')
  met? { !sudo("echo '\\du' | #{which 'psql'}", :as => 'postgres').split("\n").grep(/^\W*\b#{username}\b/).empty? }
  meet { sudo "createuser #{flags} #{username}", :as => 'postgres' }
end

# dep 'postgres backups' do
#   requires 'postgres.managed'
#   met? { shell? "test -x /etc/cron.hourly/psql_git" }
#   meet {
#     render_erb 'postgres/psql_git.rb.erb', :to => '/usr/local/bin/psql_git', :perms => '755', :sudo => true
#     sudo "ln -sf /usr/local/bin/psql_git /etc/cron.hourly/"
#   }
# end

dep 'pg', :version do
  met? { in_path? 'psql' }

  meet {
    sudo 'apt-get install -y postgresql libpq-dev'
  }
end
