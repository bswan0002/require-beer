module ProjectsHelper

  def youtube_id
    YouTubeAddy.extract_video_id(@project.vidlink)
  end

end
