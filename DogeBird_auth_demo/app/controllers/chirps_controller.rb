class ChirpsController < ApplicationController
    def index
        @chirps = Chirp.all 
        render json: @chirps
    end

    def show 
        @chirp = Chirp.find(params[:id]) 
        render json: @chirp 
    end

    def create 
        # @chirp = Chirp.new(body: params["body"], author_id: params["author_id"]) # <- original create method 
        @chirp = Chirp.new(chirp_params) # <- refer to our chirp params method below 
        if @chirp.save # checks to see if this was saved correctly into the database 
            redirect_to chirp_url(@chirp) #<-because there is a wild card in routes 
        else
            render json: @chirp.errors.full_messages, status: 422 #or unprocessable_entity # renders some nice messages
        end 
    end

    def update
        @chirp = Chirp.find(params[:id])
        if @chirp.update(chirp_params)
            redirect_to chirp_url(@chirp)
        else
            render json: @chirp.errors.full_messages, status: 422
        end
    end
    
    def destroy 
        @chirp = Chirp.find(params[:id])
        @chirp.destroy 
        render json: @chirp
        # or redirect_to chirps_url 
    end

    private 

    def chirp_params 
        params.require(:chirp).permit(:body, :author_id) #puts our params in a key called chirp, and the permit adds more security to our app
    end
end

