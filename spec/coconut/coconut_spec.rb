require 'coconut'

class  MyClass; end
module MyModule; end
module MyConfig; def self.config; end; end;

describe Coconut do
  it 'defines a config method in the provided namespace' do
    Coconut.configure(MyClass){}
    MyClass.should respond_to(:config)
    Coconut.configure(MyModule){}
    MyModule.should respond_to(:config)
  end

  it 'raises an error if the namespace already has a config method' do
    expect { Coconut.configure(MyConfig, :asset){} }.to raise_error
  end
end


