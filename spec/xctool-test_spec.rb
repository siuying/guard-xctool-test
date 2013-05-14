require 'spec_helper'

describe "Guard::XctoolTest" do
  let(:options) {
    {
      :target => 'MyTests'
    }
  }
  subject {
    watcher = stub(:watcher).as_null_object
    Guard::XctoolTest.new([watcher], options)
  }

  describe "new" do
    it "should set default option" do
      subject.target.should == "MyTests"
    end
  end

  describe "run_all" do
    it "should run all test" do
      subject.should_receive(:xctool_command).with("test")
      subject.run_all
    end
  end

  describe "run_on_changes" do
    it "should run test of the change files" do
      subject.stub(:test_classes_with_paths).and_return(["MyFirstFileSpec", "MySecondSpec"])
      subject.should_receive(:xctool_command).with("test -only MyTests:MyFirstFileSpec,MySecondSpec")
      subject.run_on_changes(["A/B/C/MyFirstFile.m", "B/D/F/MySecondSpec.m"])
    end
  end
end