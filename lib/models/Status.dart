class Status {
    String authType;
    int code;
    String message;
    String ottSessionToken;

    Status({this.authType, this.code, this.message, this.ottSessionToken});

    factory Status.fromJson(Map<String, dynamic> json) {
        return Status(
            authType: json['authType'], 
            code: json['code'], 
            message: json['message'], 
            ottSessionToken: json['ottSessionToken'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['authType'] = this.authType;
        data['code'] = this.code;
        data['message'] = this.message;
        data['ottSessionToken'] = this.ottSessionToken;
        return data;
    }
}