#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "pancetta/cli"

Pancetta::Cli.run(ARGV)
