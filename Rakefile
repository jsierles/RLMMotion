# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

require 'motion-cocoapods'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RLMMotion'
  app.pods do
    pod 'Realm', git: 'https://github.com/Realm/realm-cocoa.git', branch: 'seg-customizable-schemas'
  end
  app.bridgesupport_files << DIR + "/RealmBridgeSupport.bridgesupport"
end

DIR = File.dirname(__FILE__)
BRIDGESUPPORT_FILE = "#{DIR}/RealmBridgeSupport.bridgesupport"

namespace :gen do
  desc "Generates the bridgesupport file for RubyMotion"
  task :bridgesupport do
    Dir.chdir(DIR) do
      SHELL_COMMAND=<<-EOS.gsub(/^\s*/, '')
        #!/bin/sh
        BRIDGESUPPORT_INCLUDES=`find #{DIR}/vendor/Pods/Realm/include/Realm -type d | ruby -e "puts '-I' + STDIN.read.split(/\n/).join(' -I')"`
        BRIDGESUPPORT_FILES=`find #{DIR}/vendor/Pods/Realm/include/Realm -name "*.h" | ruby -e "puts STDIN.read.split(/\n/).join(' ')"`

        echo gen_bridge_metadata -F complete --no-64-bit -c \\\"$BRIDGESUPPORT_INCLUDES\\\" $BRIDGESUPPORT_FILES -o #{BRIDGESUPPORT_FILE}
      EOS
      command = `#{SHELL_COMMAND}`
      system command
    end
  end
end
