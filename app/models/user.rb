class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {coordinator: "Coordinación de docencia", administration_assistant: "Asistente administrativo", student: "Estudiante asistente"}
  
end
