class Api::BeaconsController < Api::BaseController
	before_action :get_beacon, except: [ :create, :index, :my_beacons]
	skip_before_filter :verify_authenticity_token, :only => [:create, :show, :destroy]


	def show
		render json: { status: 0, data: @beacon }
	end

	def create
		beacon = current_user.build_beacon(beacon_params)

		if beacon.save
			render json: { status: 0, data: beacon }
		else
			render json: { status: 2, messages: beacon.errros.first.full_message }
		end
	end


	def destroy
	end

	def index
  		beacons = Beacon.all
  		render json: { status: 0, data: beacons }
	end

	def my_beacons
		render json: { status: 0, data: current_user.beacon }, status: :ok
	end

	private

	#to create
	def beacon_params
		params.require(:beacon).permit(:unique_id, :minor, :major, :pet_image)
	end

	def get_beacon
		@beacon = Beacon.find(params[:id])

	rescue ActiveRecord::RecordNotFound
		render json: { status: 2, messages: "Not found" }
	end

end
