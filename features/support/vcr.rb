VCR.configure do |c|  
  c.cassette_library_dir = 'features/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end
