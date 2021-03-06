class I686W64Mingw32Binutils < Formula
  desc "Binutils for minimalist GNU for Windows."
  homepage "https://mingw-w64.org"
  url "https://ftpmirror.gnu.org/binutils/binutils-2.26.1.tar.bz2"
  sha256 "39c346c87aa4fb14b2f786560aec1d29411b6ec34dce3fe7309fe3dd56949fd8"
  revision 4

  depends_on "gcc" => :build

  conflicts_with "mingw-w64", :because => "homebrew-core has mingw-w64 formula"

  def install
    target_arch = "i686-w64-mingw32"
    args = %W[
      CC=gcc-6
      CXX=g++-6
      CPP=cpp-6
      LD=gcc-6
      --target=#{target_arch}
      --disable-werror
      --disable-multilib
      --prefix=#{libexec}
    ]

    system "./configure", *args
    system "make"
    system "make", "install-strip"

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats; <<-EOS.undent
    All in one minge-w64 formula is merged in Homebrew-core.
    That formula uses bottle mechanism.

    Please consider to migrate and use `mingw-w64' formula.
    This formula will continue to maintained for compatibility,
    but users should move to use homebrew-core formula.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/i686-w64-mingw32-ld --version")
  end
end
