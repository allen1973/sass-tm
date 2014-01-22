if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
end

# サーバのルートのパス
http_path = "/"
# ローカルのルートのパス
project_path = "."
# CSSの出力先ディレクトリ（project_pathからの相対パス）
css_dir = "styles"
# 画像のディレクトリ（project_pathからの相対パス）
images_dir = "images"
# JavaScriptのディレクトリ（project_pathからの相対パス）
javascripts_dir = "scripts"
# Sassのディレクトリ（project_pathからの相対パス）
sass_dir = "."
# Cacheのディレクトリ（project_pathからの相対パス）
cache_dir = "../.sass-cache"
# CSSの出力スタイル
output_style = :expanded

# その他設定
relative_assets = true
line_comments = false

# キャッシュバスターをタイムスタンプからMD5ハッシュ(10文字)に変更する
asset_cache_buster do |path, file|
  if File.file?(file.path)
    Digest::MD5.hexdigest(File.read(file.path))[0, 10]
  else
    $stderr.puts "WARNING: '#{File.basename(path)}' was not found (or cannot be read) in #{File.dirname(file.path)}"
  end
end

# スプライト画像生成時に生成されたファイル名に自動的に付けられるハッシュ文字列を削除する
on_sprite_saved do |filename|
  if File.file?(filename)
    FileUtils.mv filename, filename.gsub(%r{-s[0-9a-f]{10}(\.\w+)}, '\1')
  end
end

# スプライト画像生成時に生成されたファイル名に自動的に付けられるハッシュ文字列を削除し、
# キャッシュバスターとして利用する
on_stylesheet_saved do |filename|
  if File.file?(filename)
    css = File.read(filename)
    File.open(filename, 'w+') do |f|
      f << css.gsub(%r{-s([0-9a-f]{10})(\.\w+)}, '\2?\1')
    end
  end
end
