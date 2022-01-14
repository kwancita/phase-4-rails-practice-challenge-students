class StudentsController < ApplicationController

    def index
        render json: Student.all
    end

    def show
        student = find_student
        render json: student
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: {error: "Invalid"}, status: :unprocessable_entity 
        end
    end 

    def update
        student = find_student
        if student
            student.update(student_params)
            render json: student
        else
            render json: {error: "student not found"}, status: :not_found
        end
    end

    def destroy
        student = find_student
        if student
            student.destroy
            head :no_content
        else
            render json: {error: "student not found"}, status: :not_found
        end
    end

    private
    def find_student
        Student.find_by(id: params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
