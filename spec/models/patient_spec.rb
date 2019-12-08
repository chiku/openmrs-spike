require File.join(File.expand_path(File.dirname(__FILE__)), '..', 'spec_helper')

describe Patient do
  let :patient do
    Patient.new 10
  end

  it "has a name" do
    expect(patient.name).to eq("Patient Name 10")
  end

  it "has a doctor" do
    expect(patient.doctor_name).to eq("Doctor Name 10")
  end

  it "has an ID" do
    expect(patient.id).to eq(10)
  end

  describe "JSON representation" do
    let :decoded_json do
      json = patient.to_json
      decoded_json = JSON.load json
    end

    it "has a name" do
      expect(decoded_json['name']).to eq(patient.name)
    end

    it "has a doctor" do
      expect(decoded_json['doctor_name']).to eq(patient.doctor_name)
    end

    it "has an ID" do
      expect(decoded_json['id']).to eq(patient.id)
    end

    it "has a sex" do
      expect(['M', 'F']).to include(decoded_json['sex'])
    end

    it "has an appointment time" do
      expect(decoded_json['appointment_time']).not_to be_empty
    end
  end

  it "can be found by ID" do
    expect(Patient.find(50).id).to eq(50)
  end

  it "can be listed" do
    expect(Patient.all.count).to eq(3)
  end
end
