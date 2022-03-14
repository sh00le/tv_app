class Channel {
    String? chanGroup;
    int? chanNumber;
    int? channelId;
    String? title;
    String? logo;
    bool? hasCatchup;
    bool? ottChannel;
    bool? userSubscribed;

    Channel({this.chanGroup, this.chanNumber, this.channelId, this.hasCatchup, this.logo, this.ottChannel, this.title, this.userSubscribed});

    factory Channel.fromJson(Map<String, dynamic> json) {
        return Channel(
            chanGroup: json['chanGroup'], 
            chanNumber: json['chanNumber'], 
            channelId: int.parse(json['channelId']),
            title: json['title'],
            logo: json['logo'],
            hasCatchup: (json['hasCatchup'] == 1 || json['hasCatchup'] == true) ? true : false,
            ottChannel: (json['ottChannel'] == 1 || json['ottChannel'] == true) ? true : false,
            userSubscribed: (json['userSubscribed'] == 1 || json['userSubscribed'] == true) ? true : false,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['chanGroup'] = this.chanGroup;
        data['chanNumber'] = this.chanNumber;
        data['channelId'] = this.channelId;
        data['hasCatchup'] = this.hasCatchup;
        data['logo'] = this.logo;
        data['ottChannel'] = this.ottChannel;
        data['title'] = this.title;
        data['userSubscribed'] = this.userSubscribed;
        return data;
    }
}