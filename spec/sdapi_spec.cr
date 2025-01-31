require "./spec_helper"

describe SDAPI do
  # TODO: Write tests

  it "can generate images" do
    client = SDAPI::Client.new("http://127.0.0.1", 7860)
    request = SDAPI::Text2ImageRequest.new(
      prompt: "A photo of a woman, portrait, 30 year old, red hair, photography, trending on instagram",
      negative_prompt: "easynegative, bad quality, poorly drawn eyes, bad eyes, distorted, anime, cartoon, drawing, painting, poorly drawn, low res, bad anatomy, full body shot",
    )

    puts "REQUEST:\n\n"
    puts request.to_pretty_json

    response = client.text2image(request)

    puts "RESPONSE: \n\n"
    puts response.to_pretty_json

    # base64 decode the image
    img = Base64.decode(response.images[0])

    File.write("./spec/lisa.png", img)
  end

  it "can use extensions", focus: true do
    client = SDAPI::Client.new("http://127.0.0.1", 7860)
    
    # lisa.png as base64
    file_input_base64 = Base64.encode(File.read("./spec/lisa.png"))

    # TODO: use JSON::Parse to create JSON::Any for the entire alwayson_scripts hash
    request = SDAPI::Text2ImageRequest.new(
      prompt: "A photo of a woman, standing, outside, sunny, nature, looking at camera, trending on instagram",
      negative_prompt: "easynegative, bad quality, poorly drawn eyes, bad eyes, camera, holding camera, distorted, anime, cartoon, drawing, painting, poorly drawn, low res, bad anatomy",
      seed: 1,
      alwayson_scripts: {
        "roop" => JSON.parse({
          "is_img2img" => false,
          "is_alwayson" => true,
          "args" => [
            file_input_base64,                                                      #0 File Input
            true,                                                                   #1 Enable Roop
            "0",                                                                    #2 Comma separated face number(s)
            "/home/pelatho/AI/sd_main/stable-diffusion-webui/models/roop/inswapper_128.onnx",    #3 Model
            "CodeFormer",                                                           #4 Restore Face: None; CodeFormer; GFPGAN
            1,                                                                      #5 Restore visibility value
            true,                                                                   #6 Restore face -> Upscale
            "None",                                                                 #7 Upscaler (type 'None' if doesn't need), see full list here: http://127.0.0.1:7860/sdapi/v1/script-info -> roop-ge -> sec.8
            1,                                                                      #8 Upscaler scale value
            1,                                                                      #9 Upscaler visibility (if scale = 1)
            false,                                                                  #10 Swap in source image
            true                                                                    #11 Swap in generated image
          ]
        }.to_json)
      }
    )
    
    puts "REQUEST:\n"
    puts request.to_pretty_json

    response = client.text2image(request)

    # base64 decode the image
    img = Base64.decode(response.images[0])

    File.write("./spec/swapped_in_lisa.png", img)
  end
end
