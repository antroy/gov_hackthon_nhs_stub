# include lib dir in LOAD_PATH for ruby 1.9 compatibility
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
    s.name        = "basic_gem"
    s.version     = "0.0.1"
    s.date        = "2016-06-29"
    s.summary     = "Basic App"
    s.authors     = ["Anthony Roy"]
    s.description = "NHS Adapter Stub"
    s.homepage    = ""
    s.email       = "anthony@tech-scape.co.uk"
    s.files       = [
        'lib/**/*.rb',
        'bin/*'
    ].reduce([]){|arr,d| arr.concat Dir.glob(d).to_a}

    s.add_runtime_dependency 'trollop',         '2.0'
    s.add_runtime_dependency 'pry',             '~> 0.10'
    s.add_runtime_dependency 'grape'

    s.add_development_dependency 'rspec', '~> 3.0'
    s.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
    s.add_development_dependency 'rake',  '~> 10.3'

    s.executables = ['basic.sh', 'pry_basic.rb']

    s.require_paths = ["lib"]
end
