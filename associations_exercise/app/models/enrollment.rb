class Enrollment < ApplicationRecord
  belongs_to :courses,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Course

  belongs_to :students,
    primary_key: :id,
    foreign_key: :student_id,
    class_name: :User
end
