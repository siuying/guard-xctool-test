module Guard
  module Xctool
    module TestHelper
      # Find test class from input paths.
      # 
      # - if the path is end with Test.m/Test.mm/Spec.m/Spec.mm, then it is a test class, return the class name of it
      #
      # @param [Array<String>] paths
      #
      def test_classes_with_paths(paths, test_path=nil)
        test_classes = paths.select{|path| path =~ /(Test|Spec)\.(m|mm)$/ }   # get only Test/Spec
          .collect {|path| classname_with_file(path) }

        non_test_classes = paths.select{|path| path !=~ /(Test|Spec)\.(h|hh|m|mm)$/ }
          .collect {|path| test_file(path, test_path) }
          .compact
          .collect {|path| classname_with_file(path) }

        test_classes = non_test_classes + test_classes

        test_classes.uniq
      end

      # Give a file and a test path, find the test for the given file in the test path.
      # return nil if the test do not exists.
      #
      def test_file(file, test_path)
        return nil unless test_path

        files = Dir.glob("#{test_path}/**/#{file}(Spec|Test).(m|mm)")
        test_file = files.first
        if test_file
          classname_with_file(test_file)
        else
          test_file
        end
      end

      protected
      # Given a path of m or mm file, and return the class name
      def classname_with_file(path)
        path.split("/").last.gsub(/(\.(m|mm))$/, "")
      end
    end
  end
end