# Copyright 2017 The Ksonnet Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
require 'formula'

class Ks < Formula
  desc "The ksonnet command line utility. Manage and deploy Kubernetes applications."
  homepage 'http://ksonnet.io'

  url 'https://github.com/ksonnet/ksonnet.git', :revision => 'd38f65eee718475aab399365722097b65b2db737'
  version 'v0.1-alpha.1'

  head "https://github.com/ksonnet/ksonnet.git"

  depends_on 'go' => :build

  def install
    ENV["GOPATH"] = buildpath

    arch = MacOS.prefer_64_bit? ? "amd64" : "x86"
    dir = buildpath/"src/github.com/ksonnet/ksonnet"
    dir.install buildpath.children - [buildpath/".brew_home"]

    system "go", "env" # Debug env

    cd dir do
      system "make", "install"
    end
    bin.install "bin/ks"
  end
end