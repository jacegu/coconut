require 'coconut'


describe Coconut do
  before do
    class  MyClass; end
    module MyModule; end
  end

  after do
    Object.instance_eval do
      remove_const(:MyClass)
      remove_const(:MyModule)
    end
  end

  it 'defines a config method in the provided namespace' do
    Coconut.configure(MyClass){}
    MyClass.should respond_to(:config)
    Coconut.configure(MyModule){}
    MyModule.should respond_to(:config)
  end

  it 'defines a config constant in the provided namespace' do
    Coconut.configure(MyClass){}
    MyClass::CONFIG.should_not be_nil
    Coconut.configure(MyModule){}
    MyModule::CONFIG.should_not be_nil
  end

  it "allows the app's configuration to be run twice" do
    Coconut.configure(MyClass) { asset { env(:test){ property 'initial value' } } }
    Coconut.configure(MyClass) { asset { env(:test){ property 'latest value'  } } }
    MyClass::config.asset.property.should eq 'latest value'
  end

  it 'checks the configuration for assets without properties' do
    Kernel.should_receive(:warn).with(/asset|current environment|test/)
    Coconut.configure MyClass do
      asset {}
    end
  end

  context 'when included' do
    it 'defines a configure method' do
      module MyModule; include Coconut; end
      expect { module MyModule; configure{}; end }.not_to raise_error
    end
  end

  context 'finding out the environment' do
    before { Coconut.instance_variable_set(:@_coconut_environment, nil) }

    it 'uses the expression provided by the user if any' do
      Coconut.take_environment_from { :somewhere }
      Coconut.environment.should eq :somewhere
    end

    it 'uses the RACK_ENV environment variable by default' do
      ENV['RACK_ENV'] = 'rack_env'
      Coconut.environment.should eq 'rack_env'
    end

    it 'uses :development as environment if RACK_ENV is not defined' do
      ENV['RACK_ENV'] = nil
      Coconut.environment.should eq :development
    end
  end
end
