//  DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761
var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		if (event.data.action == 'updateJob') {
			$('#praca').html(event.data.praca);
		}
		if (event.data.action == 'updateJob2') {
			$('#praca2').html(event.data.praca2);
		}

		

		switch (event.data.action) {
			case 'toggle':
				if (visable) {
					$('#wrap').hide();
				} else {
					$('#wrap').show();
				}

				visable = !visable;
				break;

			case 'close':
				$('#wrap').hide();
				visable = false;
				break;

			case 'toggleID':

				if (event.data.state) {
					$('td:nth-child(2),th:nth-child(2)').show();
					$('td:nth-child(5),th:nth-child(5)').show();
				} else {
					$('td:nth-child(2),th:nth-child(2)').hide();
					$('td:nth-child(5),th:nth-child(5)').hide();
				}

				break;

			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#player_count').html(jobs.player_count);

				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#mecano').html(jobs.mecano);
				break;

			case 'updatePlayerList':
				$('#playerlist tr:gt(0)').remove();
				$('#playerlist').append(event.data.players);
				break;

			case 'updatePing':
				updatePing(event.data.players);
				break;

			case 'updateServerInfo':
				if (event.data.maplayerDatas) {
					$('#max_players').html(event.data.maplayerDatas);
				}

				if (event.data.uptime) {
					$('#server_uptime').html(event.data.uptime);
				}

				break;

			default:
				break;
		}
	}, false);
});

function updatePing(players) {
	jQuery.each(players, function (index, element) {
		if (element != null) {
			$('#playerlist tr:not(.heading)').each(function () {
				$(this).find('td:nth-child(2):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(2).html(element.ping);
				});

				$(this).find('td:nth-child(5):contains(' + element.id + ')').each(function () {
					$(this).parent().find('td').eq(5).html(element.ping);
				});
			});
		}
	});
}
//  DZIEKI ZA POBRANIE / BEDE STARAL SIĘ DLA WAS WRZUCAC WIĘCEJ SKRYPTÓW :D discord mtsh#1761
