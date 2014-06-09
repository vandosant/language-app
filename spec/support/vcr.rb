RSpec.configure do |config|
  VCR.configure do |c|
    c.cassette_library_dir = 'fixtures/vcr_cassettes'
    c.hook_into :webmock # or :fakeweb
    c.ignore_localhost = true
  end
end