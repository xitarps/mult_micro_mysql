module CustomQueryHandler
  def minify_query_to_single_line(query_string)
    query_string.gsub(/\s+/, ' ').strip
  end
end
