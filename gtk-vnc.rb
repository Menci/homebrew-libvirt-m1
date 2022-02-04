class GtkVnc < Formula
  desc "VNC viewer widget for GTK"
  homepage "https://wiki.gnome.org/Projects/gtk-vnc"
  url "https://download.gnome.org/sources/gtk-vnc/1.3/gtk-vnc-1.3.0.tar.xz"
  sha256 "5faaa5823b8cbe8c0b0ba1e456c4e70c4b1ae6685c9fe81a4282d98cf00a211d"
  license "LGPL-2.1-or-later"

  depends_on "gettext" => :build
  depends_on "gobject-introspection" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gnutls"
  depends_on "gtk+3"
  depends_on "libgcrypt"

  def install
    mkdir "build" do
      # This is workaround. MacOS has deprecate coroutine ucontext.
      # It needs to be fixed in gtk-vnc - use gthread coroutines.
      on_macos do
        system "meson", *std_meson_args, "-Dwith-coroutine=gthread", ".."
      end
      on_linux do
        system "meson", *std_meson_args, ".."
      end
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "#{bin}/gvnccapture", "--help"
  end
end
