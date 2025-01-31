require "json"
require "./text2image_response"

# ROOP VIA API
#"roop": {"is_alwayson": True,'args': [{'label': '', 'value': None, 'minimum': None, 'maximum': None, 'step': None, 'choices': None},{'label': 'Enable', 'value': True, 'minimum': None, 'maximum': None, 'step': None, 'choices': None},{'label': 'Comma separated face number(s)', 'value': '0', 'minimum': None, 'maximum': None, 'step': None, 'choices': None},{'label': 'Model','value': 'D:\\Documents\\stable-diffusion-webui_automatic1111_newst one\\models\\roop\\inswapper_128.onnx','minimum': None, 'maximum': None, 'step': None, 'choices':['D:\\Documents\\stable-diffusion-webui_automatic1111_newst one\\models\\roop\\inswapper_128.onnx']},{'label': 'Restore Face', 'value': 'CodeFormer', 'minimum': None, 'maximum': None, 'step': None, 'choices':['None', 'CodeFormer', 'GFPGAN']}, {'label': 'Restore visibility', 'value': 1, 'minimum': 0, 'maximum': 1, 'step': 0.1, 'choices': None},{'label': 'Upscaler', 'value': None, 'minimum': None, 'maximum': None, 'step': None,'choices': ['None', 'Lanczos', 'Nearest', 'LDSR', 'Put ESRGAN models here', 'R-ESRGAN 4x+', 'R-ESRGAN 4x+ Anime6B', 'ScuNET GAN', 'ScuNET PSNR', 'SwinIR 4x']},{'label': 'Upscaler scale', 'value': 1, 'minimum': 1, 'maximum': 8, 'step': 0.1, 'choices': None}, {'label': 'Upscaler visibility (if scale = 1)', 'value': 1, 'minimum': 0, 'maximum': 1, 'step': 0.1, 'choices': None},{'label': 'Swap in source image', 'value': True, 'minimum': None, 'maximum': None, 'step': None, 'choices': None},{'label': 'Swap in generated image', 'value': True, 'minimum': None, 'maximum': None, 'step': None, 'choices': None}]
module SDAPI
    # TODO: make JSON::Serializable NOT emit null for null values
    class Text2ImageRequest < SDAPI::Request
        include JSON::Serializable

        def method : String
            "POST"
        end

        def endpoint : String
            "/sdapi/v1/txt2img"
        end

        property prompt : String
        property negative_prompt : String?

        property styles : Array(String)?
        property seed : Int32 = -1
        property subseed : Int32 = -1
        property subseed_strength : Float32 = 0.0

        property seed_resize_from_h : Int32 = -1
        property seed_resize_from_w : Int32 = -1

        property sampler_name : String?
        property scheduler : String?
        property batch_size : Int32 = 1
        property n_iter : Int32 = 1
        property steps : Int32 = 30
        property cfg_scale : Float32 = 7.0
        property width : Int32 = 512
        property height : Int32 = 512
        property restore_faces : Bool = false
        property tiling : Bool = false
        property do_not_save_samples : Bool = false
        property do_not_save_grid : Bool = false
        property eta : Float32?
        property denoising_strength : Float32?
        property enable_hr : Bool = false
        property send_images : Bool = true
        property save_images : Bool = false

        property alwayson_scripts : Hash(String, JSON::Any)?

        def initialize(
            @prompt : String,
            @negative_prompt : String? = nil,
            @styles : Array(String)? = nil,
            @seed : Int32 = -1,
            @subseed : Int32 = -1,
            @subseed_strength : Float32 = 0.0,
            @seed_resize_from_h : Int32 = -1,
            @seed_resize_from_w : Int32 = -1,
            @sampler_name : String? = nil,
            @scheduler : String? = nil,
            @batch_size : Int32 = 1,
            @n_iter : Int32 = 1,
            @steps : Int32 = 30,
            @cfg_scale : Float32 = 7.0,
            @width : Int32 = 512,
            @height : Int32 = 512,
            @restore_faces : Bool = false,
            @tiling : Bool = false,
            @do_not_save_samples : Bool = false,
            @do_not_save_grid : Bool = false,
            @eta : Float32? = nil,
            @denoising_strength : Float32? = nil,
            @enable_hr : Bool = false,
            @send_images : Bool = true,
            @save_images : Bool = false,
            @alwayson_scripts : Hash(String, JSON::Any)? = nil
        )
        end
    end
end