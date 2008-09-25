module StringTidy
  
  def tidy(options={})
    options.reverse_merge!(:output_xhtml => true, 
      :show_body_only => true,
      :char_encoding => "utf8",
      :indent => false,
      :wrap => 0)
    
    Tidy.open(options) do |inst|
      inst.clean(self.gsub(/\302\240/, "\240"))
    end.strip!
  end
  
end