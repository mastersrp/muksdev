#!/usr/bin/env rackup
# encoding: utf-8

# This file can be used to start Padrino,
# just execute it from the command line.

require 'pry'

require File.expand_path("../config/boot.rb", __FILE__)

run Padrino.application
