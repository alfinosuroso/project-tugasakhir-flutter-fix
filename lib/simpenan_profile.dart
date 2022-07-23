
    // var responseProfil = await http.post(
    //     Uri.parse("https://spoonycal-ta.herokuapp.com/api/profile"),
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $getToken',
    //     },
    //     body: jsonEncode({
    //       'umur': getUmur,
    //       'gender': getGender,
    //       'tinggi': getTinggiBadan,
    //       'berat': getBeratBadan,
    //       'kalori_harian': finalKaloriHarian,
    //     }));

    // print(responseProfil.statusCode);

    // setState(() {
    //   tesStatus = responseProfil.statusCode;
    // });
    // if (responseProfil.statusCode == 201) {
    //   final dataProfile = jsonDecode(responseProfil.body);
    //   localStorage.setString('gender_user', dataProfile['data']['gender']);
    //   localStorage.setDouble('berat_badan', getBeratBadan!);
    //   localStorage.setDouble('tinggi_badan', getTinggiBadan!);
    //   localStorage.setDouble('umur', getUmur!);
    //   localStorage.setDouble(
    //       'kalori_harian', dataProfile['data']['kalori_harian']);

    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Styles.buttonAuthBg,
    //       content: Text("Berhasil menginputkan data!")));

    //   Navigator.popAndPushNamed(context, '/main_page');
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       backgroundColor: Styles.buttonAuthBg,
    //       content: Text("Data ada yang belum benarrr!")));
    // }