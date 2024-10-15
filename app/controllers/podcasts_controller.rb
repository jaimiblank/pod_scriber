class PodcastsController < ApplicationController
  require 'net/http'
  require 'json'

  def new
    # Renders the form for uploading a new audio file
  end

  def create
    # Get the uploaded file from the form
    audio_file = params[:podcast][:audio]

    # Save the uploaded file to a temporary location
    temp_file_path = save_file(audio_file)

    # Send the file to Whisper API for transcription
    transcription = transcribe_audio(temp_file_path)

    # Display the transcription or save it to the database
    # You could redirect to a show page or render a view here
    @transcription = transcription
    render :show
  end

  private

  def save_file(file)
    # Define where to save the uploaded file (temporary location)
    temp_path = Rails.root.join('tmp', file.original_filename)
    File.open(temp_path, 'wb') do |f|
      f.write(file.read)
    end
    temp_path
  end

  def transcribe_audio(file_path)
    # Define the API endpoint and headers
    uri = URI('https://api.openai.com/v1/audio/transcriptions')
    request = Net::HTTP::Post.new(uri)
    request['Authorization'] = "Bearer #{ENV['OPENAI_API_KEY']}"
    request.set_form([['file', File.open(file_path)], ['model', 'whisper-1'], ['response_format', 'text']], 'multipart/form-data')

    # Make the request
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    # Parse the response and return the transcription
    if response.is_a?(Net::HTTPSuccess)
      response.body
    else
      "Error: #{response.message}"
    end
  end
end

