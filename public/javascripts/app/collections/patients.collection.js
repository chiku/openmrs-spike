Application.Collections.Patients = Backbone.Collection.extend({
  model: Application.Models.Patient,

  url: Application.Configuration.Urls.patients,

  parse: function(response) {
    return response.patients;
  },

  comparator: "name",
});

Application.collections.patients = new Application.Collections.Patients;
