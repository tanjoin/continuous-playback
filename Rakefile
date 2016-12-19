# coding: utf-8

namespace :code do
  desc 'CoffeeScript から Javascript を作成'
  task :build do
    sh 'coffee -o lib/ -bc src/'
  end
end

namespace :html do
  HTML_PREFIX = """  <!DOCTYPE html>
  <html>

  <head>
      <meta charset='utf-8'>
      <title>VIDEO</title>
  </head>

  <body>
      <video id='video_player' video_index='0' controls></video>
      <br>
      <input type='button' onclick='reset()' value='リセット'>
  </body>
  <script src='lib/continuous.js'></script>
  <script>
      var videos = [  """

  HTML_SUFFIX = """      ];

      var player;
      var videoPlayer = document.getElementById('video_player');

      window.onload = function() {
        videoPlayer = document.getElementById('video_player');
        player = new Continuous(videoPlayer, videos, true, function(index, video) {
          document.title = video.replace('.mp4', "");
        });
      };

      var reset = function() {
        player.playAfterReset();
      }

      document.addEventListener('keydown', function(event) {
        console.log(event.key);
        if (event.key == ' ') {
          if (videoPlayer.paused) {
            videoPlayer.play();
          } else {
            videoPlayer.pause();
          }
        }
      });
  </script>

  </html>  """

  FILE_EXTENSION_PATTERN = "*.mp4"

  desc "Index を作成する"
  task :createIndex do
    open("build/index.html", "w") { |log|
      log.puts HTML_PREFIX
      log.puts start("video", 1)
      log.puts HTML_SUFFIX
    }
  end

  # スタート
  def start(dir, deep)
    result = ""
    cd dir do
      result = explorer(deep)
    end
    return result
  end

  # ディレクトリ探索
  def explorer(deep)
    html = ""
    html += indexer()
    return html.chop
    if deep > 0
      Dir.glob("*/").each { |dir|
        cd dir do
          html += explorer(deep - 1)
        end
      }
    end
    return html.chop
  end

  def indexer()
    html = ""
    Dir.glob("*").each { |video|
      puts video
      html += "        '#{Dir.pwd.encode("utf-8")}/#{video}',\n"
    }
    return html
  end
end
