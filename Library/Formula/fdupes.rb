require 'formula'

class Fdupes < Formula
  desc "Identify or delete duplicate files"
  homepage 'https://github.com/adrianlopezroche/fdupes'
  url 'https://github.com/adrianlopezroche/fdupes/archive/fdupes-1.51.tar.gz'
  sha1 'ac713d3f84dc9d7929f8a4dc1f7d700ddef58d60'

  bottle do
    cellar :any
    sha256 "b991062a505bdc31b1cee523b09465d5f83b0eaf78579029879d558a042f2112" => :yosemite
    sha256 "6b4a3d6d54bae82b8f41975aad6b90c440ccb95901a909fee594bbbc7b0be1db" => :mavericks
    sha256 "d8e9918fda3c8499aef07cc4a0d0f1b7b0a39932b6ff69f1e96583213bac3657" => :mountain_lion
  end

  def install
    inreplace "Makefile", "gcc", "#{ENV.cc} #{ENV.cflags}"
    system "make fdupes"
    bin.install "fdupes"
    man1.install "fdupes.1"
  end

  test do
    touch "a"
    touch "b"

    dupes = shell_output("#{bin}/fdupes .").strip.split("\n").sort
    assert_equal ["./a", "./b"], dupes
  end
end
