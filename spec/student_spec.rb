require "spec_helper"
require "../lib/Student"


RSpec.describe(Student) do
  let(:student) { Student.new(    :hair_color => "brown",     :eye_color => "blue",     :first_name => "Julie",     :last_name => "Smith",     :age => 5) }

  it("#hair_color") do
    expect(student.hair_color).to(eq("brown"))
  end

  it("#eye_color") do
    expect(student.eye_color).to(eq("blue"))
  end

  it("#first_name") do
    expect(student.first_name).to(eq("Julie"))
  end

  it("#last_name") do
    expect(student.last_name).to(eq("Smith"))
  end

  it("#age") do
    expect(student.age).to(eq(5))
  end
end
