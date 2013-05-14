require 'spec_helper'

describe "Guard::XctoolHelper" do
  subject {
    object = Object.new
    object.send :extend, Guard::XctoolHelper
  }
  describe "::test_classes_with_paths" do
    it "should return list of file name that ends with Spec or Test" do
      files  = ["ProjectTests/A/B/C/File1Test.m", "ProjectTests/A/B/C/File2Spec.m", "Project/A/B/C/File3.h", "Project/A/B/C/File2.m"]
      test_files = subject.test_classes_with_paths(files, "ProjectTests")
      test_files.should be_include("File1Test")
      test_files.should be_include("File2Spec")
      test_files.should_not be_include("File2")
      test_files.should_not be_include("File3")
    end

    it "should return test file of non-test classes" do
      # mock glob op, pretent we have File3Spec on disk
      Dir.stub(:glob).and_return(["ProjectTests/A/File3Spec.m"])

      files  = ["ProjectTests/A/B/C/File1Test.m", "ProjectTests/A/B/C/File2Spec.m", "Project/A/B/C/File3.h", "Project/A/B/C/File2.m"]
      test_files = subject.test_classes_with_paths(files, "ProjectTests")
      test_files.should be_include("File1Test")
      test_files.should be_include("File2Spec")
      test_files.should be_include("File3Spec")
      test_files.should_not be_include("File2")
      test_files.should_not be_include("File3")
    end
  end

  describe "::test_file" do 
    it "should use glob to find the target file" do
      Dir.should_receive(:glob).with("ProjectTests/**/MyFile*.*").and_return(["ProjectTests/A/MyFileSpec.m"])
      test_file = subject.test_file("Project/A/MyFile.m", "ProjectTests")
      test_file.should == "ProjectTests/A/MyFileSpec.m"
    end

    it "should find correct test file if glob return two files having same prefix" do
      Dir.stub(:glob).and_return(["ProjectTests/A/MyFile2Spec.m", "ProjectTests/A/MyFileSpec.m"])
      test_file = subject.test_file("Project2/A/MyFile.m", ["ProjectTests"])
      test_file.should == "ProjectTests/A/MyFileSpec.m"
    end

    it "should accept array of paths" do
      Dir.stub(:glob).and_return([], ["ProjectTests2/A/MyFileSpec.m"])
      test_file = subject.test_file("Project2/A/MyFile.m", ["ProjectTests", "ProjectTests2"])
      test_file.should == "ProjectTests2/A/MyFileSpec.m"
    end

    it "should return nil if one does not exists" do
      Dir.stub(:glob).and_return([])
      test_file = subject.test_file("Project/A/MyFile.m", "ProjectTests")
      test_file.should be_nil
    end
  end

  describe "::find_test_target" do
    it "should use xcodeproj to find test target" do
      Dir.stub(:'[]').and_return(["MyProject.xcodeproj"])
      stub_target = stub(:target)
      stub_target.stub(:name).and_return("MyProjectSpec")
      stub_project = stub(:project)
      stub_project.stub(:targets).and_return([stub_target])
      Xcodeproj::Project.stub(:new).and_return(stub_project)

      target = subject.find_test_target
      target.should == "MyProjectSpec"
    end
  end
end