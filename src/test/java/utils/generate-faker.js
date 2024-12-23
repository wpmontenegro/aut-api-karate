function () {
  var Locale = Java.type('java.util.Locale')
  var Faker = Java.type('net.datafaker.Faker')
  var faker = new Faker(new Locale("es"));
  var name = faker.name().fullName();
  var job = faker.job().title();
  var message = faker.hobby().activity();
  return {name, job, message}
}