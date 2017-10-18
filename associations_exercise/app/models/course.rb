class Course < ApplicationRecord
  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment

  has_many :enrolled_students,
    through: :enrollments,
    source: :students

  belongs_to :prerequisites,
    primary_key: :id,
    foreign_key: :prereq_id,
    class_name: :Course

  belong_to :instructor,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :User
end
