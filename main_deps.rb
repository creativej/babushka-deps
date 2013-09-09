dep 'dev' do
  requires(
    # 'essentials',
    'git setup',
    'vim',
    '2.0.0-p247.rbenv',
    'gems',
    'nodejs',
    'common:set.locale',
    'pg.gem'
  )
end

dep 'prod' do
  requires(
    'essentials',
    'git setup',
    'vim',
    '2.0.0-p247.rbenv',
    'gems',
    'nodejs',
    'pg.gem'
  )
end
