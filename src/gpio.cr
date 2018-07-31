require "./gpio/*"

module GPIO
  alias FileDescriptor = Int32
  alias Pin = UInt32
  alias Flag = UInt32

  @[Link(ldflags: "#{__DIR__}/../gpio-sysfs/gpio-sysfs.o")]
  lib CGPIO
    fun version = "gpio_sysfs_version"() : LibC::Char*
    fun export = "gpio_export"(gpio : Pin) : Int32
    fun unexport = "gpio_unexport"(gpio : Pin) : Int32
    fun set_dir = "gpio_set_dir"(gpio : Pin, out_flag : Flag) : Int32
    fun set_value = "gpio_set_value"(gpio : Pin, out_flag : Flag) : Int32
    fun get_value = "gpio_get_value"(gpio : Pin, out_flag : Pointer(Flag)) : Int32
    fun set_edge = "gpio_set_edge"(gpio : Pin, edge : LibC::Char*) : Int32
    fun fd_open = "gpio_fd_open"(gpio : Pin) : Int32
    fun fd_close = "gpio_fd_close"(fd : FileDescriptor) : Int32
    fun poll = "gpio_poll"(fd : FileDescriptor, timeout : Int32) : Int32
  end

  def self.version
    String.new(CGPIO.version())
  end

  puts version()
end
