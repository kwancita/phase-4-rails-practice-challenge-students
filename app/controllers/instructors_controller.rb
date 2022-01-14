class InstructorsController < ApplicationController

    def index
        render json: Instructor.all
    end

    def show
        instructor = find_instructor
        render json: instructor
    end

    def create
        instructor = Instructor.create(instructor_params)
        if instructor.valid?
            render json: instructor, status: :created
        else
            render json: {error: "Invalid"}, status: :unprocessable_unity
        end
    end 

    def update
        instructor = find_instructor
        if instructor
            instructor.update(instructor_params)
            render json: instructor
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    def destroy
        instructor = find_instructor
        if instructor
            instructor.destroy
            head :no_content
        else
            render json: {error: "Instructor not found"}, status: :not_found
        end
    end

    private
    def find_instructor
        Instructor.find_by(id: params[:id])
    end

    def instructor_params
        params.permit(:name)
    end

end
