IRBRC_D = File.join(File.dirname(__FILE__), '.irbrc.d')

$:.unshift(IRBRC_D) unless
  $:.include?(IRBRC_D) || $:.include?(File.expand_path(IRBRC_D))

# General Requires
%w(rubygems pp hirb wirble irb/completion awesome_print).each do |gem|
    begin
      require gem
    rescue Exception => err
      puts "#{err.class} requiring #{gem}! Is it installed?"
    end
end

Dir.glob(File.join(IRBRC_D, '*.rb')).each do |monkey_patch|
  require monkey_patch
end

if defined? Rails then
  environ = Rails.env
elsif ENV['RACK_ENV']
  environ = ENV['RACK_ENV']
else
  environ = ""
end

env = case environ.downcase
  when "production" then
    Wirble::Colorize.colorize_string(environ, :red)
  when "development" then
    Wirble::Colorize.colorize_string(environ, :green)
  when "test" then
    Wirble::Colorize.colorize_string(environ, :yellow)
  else
    environ
end

IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I => "(#{env})[%03n:%i> ",
  :PROMPT_N => "(#{env})[%03n:%i> ",
  :PROMPT_S => "(#{env})[%03n:%i%l ",
  :PROMPT_C => "(#{env})[%03n:%i* ",
  :RETURN => "=> %s\n"
}

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true
IRB.conf[:PROMPT_MODE] = :CUSTOM

if(defined? Wirble) then
  # Wirble Initialization
  module Wirble
    class History
      def save_history
        path, max_size, perms = %w{path size perms}.map { |v| cfg(v) }

        # read lines from history, and truncate the list (if necessary)
        lines = Readline::HISTORY.to_a.inject([]){|a,e|next(a) if a.last==e;(a + [e])}
        lines.pop if lines.last=='exit'
        lines = lines[-max_size, -1] if lines.size > max_size

        # write the history file
        real_path = File.expand_path(path)
        real_path_by_date = real_path + '_by_date'
        Dir.mkdir(real_path_by_date) unless File.exists? real_path_by_date
        real_path_by_date =File.join( real_path_by_date, Time.now.strftime('%Y_%m_%d__%H_%M_%S'))
        real_path = File.expand_path(path)
        File.open(real_path, perms) { |fh| fh.puts lines }
        File.open(real_path_by_date, perms) { |fh| fh.puts lines }
        say 'Saved %d lines to history file %s.' % [lines.size, path]
      end
    end
  end

  #Wirble Color Map
    #:nothing        :green            :light_purple
    #:black          :light_blue       :purple
    #:blue           :light_cyan       :red
    #:brown          :light_gray       :white
    #:cyan           :light_green      :yellow
    #:dark_gray      :light_red
  Wirble.init({
    # skip shortcuts
    :skip_shortcuts => true,

    # don't set the prompt
    :skip_prompt    => true,

    # override some of the default colors
    :colors => {
      # delimiter colors
      :comma              => :blue,
      :refers             => :blue,

      # container colors (hash and array)
      :open_hash          => :green,
      :close_hash         => :green,
      :open_array         => :green,
      :close_array        => :green,

      # object colors
      :open_object        => :light_red,
      :object_class       => :white,
      :object_addr_prefix => :blue,
      :object_line_prefix => :blue,
      :close_object       => :light_red,

      # symbol colors
      :symbol             => :yellow,
      :symbol_prefix      => :yellow,

      # string colors
      :open_string        => :red,
      :string             => :cyan,
      :close_string       => :red,

      # misc colors
      :number             => :cyan,
      :keyword            => :green,
      :class              => :light_green,
      :range              => :red,
    },

    # enable color
    :init_color     => true,
  })
  Wirble.colorize
end

if(defined? Hirb) then
  # Hirb Initialization
  # http://tagaholic.me/hirb/doc/classes/Hirb/View.html
  Hirb::Formatter.dynamic_config['ActiveRecord::Base'] if (defined? Rails)
  Hirb::Formatter.dynamic_config['Sequel::Model'] if ENV['RACK_ENV']
  Hirb.enable
  Hirb.enable :pager => true
  Hirb.enable :formatter => true
end

