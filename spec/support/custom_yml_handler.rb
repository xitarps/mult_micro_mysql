module CustomYmlHandler
  def yml_hash_from_query_file(file_path)
    YAML.load_file("#{fixture_paths.first.to_s.gsub('**/*', '')}/files/queries/#{file_path}").deep_symbolize_keys
  end
end
