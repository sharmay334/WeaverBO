function getRummyWagerHourWise(abc){
	var x;	
	if(abc!=null){
		if(abc.length!=0){
			var time = ["01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00",
			            "10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","00:00"];
			var data1 = [];
			for(var i=1;i<abc[0].length;i++){
				if(abc[0][i]=="0E-12")
					abc[0][i]= 0;
				else
					abc[0][i] = Number(abc[0][i]);
				data1[i-1] = abc[0][i];
			}
			var data2 = [];
			for(var i=1;i<abc[1].length;i++){
				if(abc[1][i]=="0E-12")
					abc[1][i]= 0;
				else
					abc[1][i] = Number(abc[1][i]);
				data2[i-1] = abc[1][i];
			}
			var data3 = [];
			for(var i=1;i<abc[2].length;i++){
				if(abc[2][i]=="0E-12")
					abc[2][i]= 0;
				else
					abc[2][i] = Number(abc[2][i]);
				data3[i-1] = abc[2][i];
			}
			var data4 = [];
			for(var i=1;i<abc[3].length;i++){
				if(abc[3][i]=="0E-12")
					abc[3][i]= 0;
				else
					abc[3][i] = Number(abc[3][i]);
				data4[i-1] = abc[3][i];
			}
			var date = new Date();
			var currTime = date.getHours()+':'+date.getMinutes();
			var count=1;
			for(i=0;i<time.length;i++){
				if(parseInt(time[i].split(":")[0])<=parseInt(currTime.split(":")[0])){
				count++;
			}else{
				break;
			}
			}
			count--;
			for(i=data1.length+1;i>count+1;i--){
				data1.pop();	
							
			}
		}
		var depChart = Highcharts.chart('getRummyWagerHourWise',{
			credits: {
			    enabled: false
			  },
			colors: ['#90ED7D', '#7CB5EC', '#F9B47B', '#434348'],
			chart: {
				type: 'line'
			},
			title: {
				text: 'Rummy Wager Hour Wise'
			},
			xAxis: {
				title: {
					//text: 'Time'
				},
				categories: time,
				gridLineWidth: 1
			},
			yAxis: {
				title: {
					text: 'Amount'
				},
				 min: 0,
 				 tickInterval:1000,
			 plotLines: [{
	                value: 0,
	                width: 1,
	                color: '#808080'
	            }]
			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			/*tooltip: {
				headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				pointFormat: '<tr><td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
				footerFormat: '</table>',
				shared: true,
				useHTML: true
			},*/
			plotOptions: {
				line: {
					dataLabels: {
						enabled: false
					},
					enableMouseTracking: true
				}
			},
			series: [{
				name: abc[3][0],
				data: data4

			}, {
				name: abc[2][0],
				data: data3

			}, {
				name: abc[1][0],
				data: data2

			}, {
				name: abc[0][0],
				data: data1

			}]
		});
	}else{
		var depChart = Highcharts.chart('getRummyWagerHourWise',{
			credits: {
			    enabled: false
			  },
			chart: {
				type: 'line'
			},
			title: {
				text: 'Rummy Wager Hour Wise'
			},
			xAxis: {
				title: {
					//text: 'Time'
				},
				categories: time
			},
			yAxis: {
				title: {
					text: 'Amount'
				}

			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			/*tooltip: {
				headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
				'<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
				footerFormat: '</table>',
				shared: true,
				useHTML: true
			},*/
			plotOptions: {
				line: {
					dataLabels: {
						enabled: false
					},
					enableMouseTracking: true
				}
			},
			series: [{
				name: 'Day',
				data: []
			}],
			
		});
	}	
}

function getRummyWagerDayWise(abc){
	var x;	
	if(abc!=null){
		if(abc.length!=0){
			var time = ["01:00","02:00","03:00","04:00","05:00","06:00","07:00","08:00","09:00",
			            "10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00","00:00	"];
			var data1 = [];
			for(var i=1;i<abc[0].length;i++){
				if(abc[0][i]=="0E-12")
					abc[0][i]= 0;
				else
					abc[0][i] = Number(abc[0][i]);
				data1[i-1] = abc[0][i];
			}
			var data2 = [];
			for(var i=1;i<abc[1].length;i++){
				if(abc[1][i]=="0E-12")
					abc[1][i]= 0;
				else
					abc[1][i] = Number(abc[1][i]);
				data2[i-1] = abc[1][i];
			}
			var data3 = [];
			for(var i=1;i<abc[2].length;i++){
				if(abc[2][i]=="0E-12")
					abc[2][i]= 0;
				else
					abc[2][i] = Number(abc[2][i]);
				data3[i-1] = abc[2][i];
			}
			var data4 = [];
			for(var i=1;i<abc[3].length;i++){
				if(abc[3][i]=="0E-12")
					abc[3][i]= 0;
				else
					abc[3][i] = Number(abc[3][i]);
				data4[i-1] = abc[3][i];
			}
			var date = new Date();
			var currTime = date.getHours()+':'+date.getMinutes();
			var count=0;
			for(i=0;i<time.length;i++){
				if(parseInt(time[i].split(":")[0])<=parseInt(currTime.split(":")[0])){
				count++;
			}else{
				break;
				}
			}
			for(i=data1.length-1;i>=count;i--){
				data1.pop();
			}
		}
		Highcharts.chart('getRummyWagerDayWise',{
			credits: {
			    enabled: false
			  },
			colors: ['#90ED7D', '#7CB5EC', '#F9B47B', '#434348'],
			chart: {
				type: 'line'
			},
			title: {
				text: 'Rummy Wager Day Wise'
			},
			xAxis: {
				title: {
					//text: 'Time'
				},
				categories: time,
				gridLineWidth: 1
			},
			yAxis: {
				title: {
					text: 'Amount'
				},
				  min: 0,
				  tickInterval: 20000,
				 
			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			/*tooltip: {
				headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
				pointFormat: '<tr><td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
				footerFormat: '</table>',
				useHTML: true,
				shared: true
			},*/
			plotOptions: {
				line: {
					dataLabels: {
						enabled: false
					},
					enableMouseTracking: true
				}
			},
			series: [{
			
				name: abc[3][0],
				data: data4

			}, {
			
				name: abc[2][0],
				data: data3

			}, {
				
				name: abc[1][0],
				data: data2

			}, {
				name: abc[0][0],
				data: data1

			}
			
			]

		});
	}
}



function getTotalPokerWagerDayWise(abc){
	var x;	
	var mySeries = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows.length!=0){
			for(i=0;i < abc.data.rows[0].values.length ;i++){					
				mySeries.push([abc.data.rows[0].keys[i],abc.data.rows[0].values[i]]);
				d.push(abc.data.rows[0].keys[i]);
			}
		}
		var depChart = Highcharts.chart('getTotalPokerWagerDayWise',{
			credits: {
			    enabled: false
			  },
			colors: ['#434348', '#8085E9', '#434348', '#8085E9', '#434348', '#8085E9', '#434348'],
			chart: {
				type: 'column'
			},
			title: {
				text: 'Daily Poker Rake'
			},
			xAxis: {
				title: {
					//text: 'Day'
				},
				categories: d
			},
			yAxis: {
				title: {
					text: 'Amount'
				}
			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			plotOptions: {
				series: {
					borderWidth: 0,
					dataLabels: {
						enabled: false,
						rotation: -90,
						/*format: 'Rs.{point.y:.2f}'*/
						format: '{point.y:.2f}'
					}
				}
			},

			tooltip: {
				headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				/*pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>Rs.{point.y:.2f}</b><br/>'*/
				pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b><br/>'
			},

			series: [{
				name: 'Amount',
				showInLegend: false,
				colorByPoint: true,
				data: mySeries
				
			}]

		});
		
	}
}

function getTotalDepAmtDayWise(abc){
	var x;
	var mySeries = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows.length!=0){
			for(i=0;i < abc.data.rows[0].values.length ;i++){					
				mySeries.push([abc.data.rows[0].keys[i],abc.data.rows[0].values[i]]);
				d.push(abc.data.rows[0].keys[i]);
			}
		}

		Highcharts.chart('getTotalDepAmtDayWise', {
			credits: {
			    enabled: false
			  },
			colors: ['#434348', '#F7A35C', '#434348', '#F7A35C', '#434348', '#F7A35C', '#434348'],
			chart: {
				type: 'column'
			},
			title: {
				text: 'Daily Deposits'
			},
			xAxis: {
				title: {
					//text: 'Day'
				},
				categories: d
			},
			yAxis: {
				
				title: {
					text: 'Amount'
				}

			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			plotOptions: {
				series: {
					borderWidth: 0,
					dataLabels: {
						enabled: false,
						rotation: -90,
						color: '#FFFFFF',
						format: '{point.y}',
						align: 'right',
						//y:-0, // 10 pixels down from the top
		                style: {
		                    fontSize: '11px',
		                    fontFamily: 'Verdana, sans-serif'
		                }
					}
				}
			},

			tooltip: {
				headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				/*pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>Rs.{point.y:.2f}</b><br/>'*/
				pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b><br/>'
			},

			series: [{
				name: 'Amount',
				showInLegend: false,
				colorByPoint: true,
				data: mySeries
			}],

		});
	
	}
}

function getTotalRummyWagerDayWise(abc){
	var x;	
	var mySeries = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows.length!=0){
			for(i=0;i < abc.data.rows[0].values.length ;i++){					
				mySeries.push([abc.data.rows[0].keys[i],abc.data.rows[0].values[i]]);
				d.push(abc.data.rows[0].keys[i]);
			}
		}
		Highcharts.chart('getTotalRummyWagerDayWise', {
			credits: {
			    enabled: false
			  },
			colors: ['#434348', '#7cb5ec', '#434348', '#7cb5ec', '#434348', '#7cb5ec', '#434348'],
			chart: {
				type: 'column'
			},
			title: {
				text: 'Daily Rummy Wager'
			},
			xAxis: {
				title: {
					//text: 'Day	'
				},
				categories: d
			},
			yAxis: {
				title: {
					text: 'Amount'
				}
			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			plotOptions: {
				series: {
					borderWidth: 0,
					dataLabels: {
						enabled: false,
						/*format: 'Rs.{point.y:.2f}'*/
						format: '{point.y:.2f}'
					}
				}
			},

			tooltip: {
				headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				/*pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>Rs.{point.y:.2f}</b><br/>'*/
				pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b><br/>'
			},
			series: [{
				name: 'Amount',
				showInLegend: false,
				colorByPoint: true,
				data: mySeries
			}],
		});
	}
}

function getTotalWithDrawDayWise(abc){
	var x;	
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows.length!=0){
			var mySeries = [];
			var d = [];
			for(i=0;i < abc.data.rows[0].values.length ;i++){					
				mySeries.push([abc.data.rows[0].keys[i],abc.data.rows[0].values[i]]);
				d.push(abc.data.rows[0].keys[i]);
			}
		}

		Highcharts.chart('getTotalWithDrawDayWise',{
			credits: {
			    enabled: false
			  },
			colors: ['#434348', '#90ED7D', '#434348', '#90ED7D', '#434348', '#90ED7D', '#434348'],
			chart: {
				type: 'column'
			},
			title: {
				text: 'Daily Withdrawal Request'
			},
			xAxis: {
				title: {
					//text: 'Day	'
				},
				categories: d
			},
			yAxis: {
				title: {
					text: 'Amount'
				}

			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			plotOptions: {
				series: {
					borderWidth: 0,
					dataLabels: {
						enabled: false,
						/*format: 'Rs.{point.y:.2f}'*/
						format: '{point.y:.2f}'
					}
				}
			},

			tooltip: {
				headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				/*pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>Rs.{point.y:.2f}</b><br/>'*/
				pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}</b><br/>'
			},

			series: [{
				name: 'Amount',
				showInLegend: false,
				colorByPoint: true,
				data: mySeries
			}],
		});
	}	
}

function getTotalRegDayWise(abc){
	var x;		
	var data1 = [];
	var data2 = [];
	var data3 = [];
	var data4 = [];
	var data5 = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows!=null){					
			if(abc.data.rows.length!=0){
				for(i=0;i < abc.data.rows[0].values.length ;i++){				
					data1.push(abc.data.rows[0].values[i]);
					data2.push(abc.data.rows[1].values[i]);
					data3.push(abc.data.rows[2].values[i]);
					data4.push(abc.data.rows[3].values[i]);
					data5.push(abc.data.rows[4].values[i]);
					d.push(abc.data.columnKeys[i]);
				}
			}	
			Highcharts.chart('getTotalRegDayWise',{
				credits: {
				    enabled: false
				  },
				chart: {
					type: 'column'
				},
				title: {
					text: 'Daily New Registration'
				},

				xAxis: {
					title: {
						//text: 'Day'
					},
					categories: d
				},
				yAxis: {
					title: {
						text: 'Number of Registrations'
					}
				},
				legend: {
					verticalAlign: 'bottom',
					//floating: true,
					backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
					borderColor: '#CCC',
					borderWidth: 1,
					shadow: false
				},
				tooltip: {
					headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
					pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
					'<td style="padding:0"><b>{point.y}</b></td></tr>',
					footerFormat: '</table>',
					shared: true,
					useHTML: true
				},
				plotOptions: {
					column: {
						pointPadding: 0.2,
						borderWidth: 0,
						dataLabels: {
							enabled: false,
							format: '{point.y}'
						}
					}
				},
				series: [
				         {
				        	 name: 'DIRECT',
				        	 data: data1
				         }, {
				        	 name: 'PPC',
				        	 data: data2
				         }, {
				        	 name: 'REFER FRIEND',
				        	 data: data3
				         }, {
				        	 name: 'OLA',
				        	 data: data4
				         },
				         {
				        	 name: 'AFFILIATE',
				        	 data: data5
				         }],
			});
		}
	}	
}

function getTotalDepRequestStatus(abc){
	var x;	
	var data1 = [];
	var data2 = [];
	var data3 = [];
	var data4 = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows!=null){					
			if(abc.data.rows.length!=0){
				for(i=0;i < abc.data.rows[0].values.length ;i++){				
					data1.push(abc.data.rows[0].values[i]);
					data2.push(abc.data.rows[1].values[i]);
					data3.push(abc.data.rows[2].values[i]);
					data4.push(abc.data.rows[3].values[i]);
					d.push(abc.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getTotalDepRequestStatus',{
				credits: {
				    enabled: false
				  },
					chart: {
						type: 'column'
					},
					title: {
						text: 'Daily Deposit Request Status'
					},
					xAxis: {
						categories: d,
						crosshair: true
					},
					yAxis: {
						//min: 0,
						title: {
							text: 'Number of Deposit Request'
						},
						stackLabels: {
							enabled: false,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						}
					},
					legend: {
						verticalAlign: 'bottom',
						//floating: true,
						backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
						borderColor: '#CCC',
						borderWidth: 1,
						shadow: false
					},
					tooltip: {
						headerFormat: '<b>{point.x}</b><br/>',
						pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
					},
					plotOptions: {
						column: {
							//stacking: 'normal',
							dataLabels: {
								enabled: false,
								color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
							}
						}
					},
					series: [{
						name: 'DONE',
						data: data4

					}, {
						name: 'INITIATED',
						data: data2

					}, {
						name: 'FAILED',
						data: data3

					}, {
						name: 'PENDING',
						data: data1

					}],
				});
		}
	}	
}

function getTotalBonusDayWise(abc){
	var x;	
	var data1 = [];
	var data2 = [];
	var d = [];
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows!=null){					
			if(abc.data.rows.length!=0){

				for(i=0;i < abc.data.rows[0].values.length ;i++){				
					data1.push(abc.data.rows[0].values[i]);
					data2.push(abc.data.rows[1].values[i]);
					d.push(abc.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getTotalBonusDayWise',{
				credits: {
				    enabled: false
				  },
					chart: {
						type: 'column'
					},
					title: {
						text: 'Daily Bonus Status'
					},
					xAxis: {
						categories: d,
						crosshair: true
					},
					yAxis: {
						min: 0,
						title: {
							text: 'Amount'
						},
						/*stackLabels: {
							enabled: false,
							style: {
								fontWeight: 'bold',
								color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
							}
						}*/
					},
					legend: {
						verticalAlign: 'bottom',
						//floating: true,
						backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
						borderColor: '#CCC',
						borderWidth: 1,
						shadow: false
					},
					tooltip: {
						headerFormat: '<b>{point.x}</b><br/>',
						pointFormat: '{series.name}: {point.y}<br/>Total: {point.stackTotal}'
					},
					plotOptions: {
						column: {
							//stacking: 'normal',
							dataLabels: {
								enabled: false,
								color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
							}
						}
					},
					series: [{
						name: 'TOTAL BONUS',
						data: data1

					}, {
						name: 'CONVERT TO CASH',
						data: data2

					}],
					
			        

				});
			}
		}
	}

function getTotalNgrSlotDayWise(data){
	var x;	
	var data1 = [];
	var d = [];
	if(data!=null && data.data!=null && data.data.rows!=null){
		if(data.data.rows!=null){					
			if(data.data.rows.length!=0){
				for(i=0;i < data.data.rows[0].values.length ;i++){				
					data1.push(data.data.rows[0].values[i]);
					d.push(data.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getTotalNgrSlotDayWise',{
				credits: {
				    enabled: false
				  },
				colors: ['#434348', '#90ED7D', '#434348', '#90ED7D', '#434348', '#90ED7D', '#434348'],
				chart: {
			            type: 'column'
			        },	
			        title: {
			            text: 'Daily SLOT NGR'
			        },  
			        xAxis: {
			            categories: d
			        }, 
			        series: [{
						colorByPoint: true,
						data:data1,
			        	showInLegend: false
					}],
			});
		}
	}	
}



function getTotalNgrIgeDayWise (data){
	var x;	
	var data1 = [];
	var d = [];
	if(data!=null && data.data!=null && data.data.rows!=null){
		if(data.data.rows!=null){					
			if(data.data.rows.length!=0){
				for(i=0;i < data.data.rows[0].values.length ;i++){				
					data1.push(data.data.rows[0].values[i]);
					d.push(data.data.columnKeys[i]);
				}
			}
			
			Highcharts.chart('getTotalNgrIgeDayWise',{
				credits: {
				    enabled: false
				  },
				colors: ['#434348', '#F7A35C', '#434348', '#F7A35C', '#434348', '#F7A35C', '#434348'],
				chart: {
			            type: 'column'
			        },	
			        title: {
			            text: 'Daily IGE NGR'
			        },  
			        xAxis: {
			            categories: d
			        }, 
			        series: [{
			        	showInLegend: false,
			        	data :data1,
			        	colorByPoint: true
					}],
			});


		}
	}	
}


function getWagerAndWinningGameWise(data){
	var x;	
	var data1 = [];
	var data2 = [];
	var d = [];
	if(data!=null && data.data!=null && data.data.rows!=null){
		if(data.data.rows!=null){					
			if(data.data.rows.length!=0){
				for(i=0;i < data.data.rows[0].values.length ;i++){				
					data1.push(data.data.rows[0].values[i]);
					data2.push(data.data.rows[1].values[i]);
					d.push(data.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getWagerAndWinningGameWise', {
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: 'DGE Wager Winning Day Wise'
			    },
			    xAxis: {
			        categories: d
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Winning / Wager'
			        }
			    },
			    legend: {
					verticalAlign: 'bottom',
					//floating: true,
					backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
					borderColor: '#CCC',
					borderWidth: 1,
					shadow: false
				},
			    tooltip: {
			        headerFormat: '<b>{point.x}</b><br/>',
			        pointFormat: '{series.name}: {point.y}<br/>'
			    },
			    plotOptions: {
			        column: {
			            stacking: 'normal'
			        }
			    },
			    series: [{
			        name: 'Wager',
			        data: data1
			    }, {
			        name: 'Winning',
			        data: data2
			    }]
			});
		}
	}	
	$(".highcharts-credits").hide();
}
function getSBSWagerAndWinning(data){
	var x;	
	var data1 = [];
	var data2 = [];
	var d = [];
	if(data!=null && data.data!=null && data.data.rows!=null){
		if(data.data.rows!=null){					
			if(data.data.rows.length!=0){
				for(i=0;i < data.data.rows[0].values.length ;i++){				
					data1.push(data.data.rows[0].values[i]);
					data2.push(data.data.rows[1].values[i]);
					d.push(data.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getSBSWagerAndWinning', {
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: 'SBS Wager Winning Day Wise'
			    },
			    xAxis: {
			        categories: d
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Winning / Wager'
			        }
			    },
			    legend: {
					verticalAlign: 'bottom',
					//floating: true,
					backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
					borderColor: '#CCC',
					borderWidth: 1,
					shadow: false
				},
			    tooltip: {
			        headerFormat: '<b>{point.x}</b><br/>',
			        pointFormat: '{series.name}: {point.y}<br/>'
			    },
			    plotOptions: {
			        column: {
			            stacking: 'normal'
			        }
			    },
			    series: [{
			        name: 'Wager',
			        data: data1
			    }, {
			        name: 'Winning',
			        data: data2
			    }]
			});
		}
	}	
	$(".highcharts-credits").hide();
}
function getSLEWagerAndWinning(data){
	var x;	
	var data1 = [];
	var data2 = [];
	var d = [];
	if(data!=null && data.data!=null && data.data.rows!=null){
		if(data.data.rows!=null){					
			if(data.data.rows.length!=0){
				for(i=0;i < data.data.rows[0].values.length ;i++){				
					data1.push(data.data.rows[0].values[i]);
					data2.push(data.data.rows[1].values[i]);
					d.push(data.data.columnKeys[i]);
				}
			}
			Highcharts.chart('getSLEWagerAndWinning', {
			    chart: {
			        type: 'column'
			    },
			    title: {
			        text: 'SLE Wager Winning Day Wise'
			    },
			    xAxis: {
			        categories: d
			    },
			    yAxis: {
			        min: 0,
			        title: {
			            text: 'Winning / Wager'
			        }
			    },
			    legend: {
					verticalAlign: 'bottom',
					//floating: true,
					backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
					borderColor: '#CCC',
					borderWidth: 1,
					shadow: false
				},
			    tooltip: {
			        headerFormat: '<b>{point.x}</b><br/>',
			        pointFormat: '{series.name}: {point.y}<br/>'
			    },
			    plotOptions: {
			        column: {
			            stacking: 'normal'
			        }
			    },
			    series: [{
			        name: 'Wager',
			        data: data1
			    }, {
			        name: 'Winning',
			        data: data2
			    }]
			});
		}
	}	
	$(".highcharts-credits").hide();
}
function getTotalRummyRakeDayWise(abc){
	var x;	
	if(abc!=null && abc.data!=null && abc.data.rows!=null){
		if(abc.data.rows.length!=0){
			var mySeries = [];
			var d = [];
			for(i=0;i < abc.data.rows[0].values.length ;i++){					
				mySeries.push([abc.data.rows[0].keys[i],abc.data.rows[0].values[i]]);
				d.push(abc.data.rows[0].keys[i]);
			}
		}

		Highcharts.chart('getTotalRummyRakeDayWise',{
			credits: {
				enabled: false
			},
			colors: ['#434348', '#90ED7D', '#434348', '#90ED7D', '#434348', '#90ED7D', '#434348'],
			chart: {
				type: 'column'
			},
			title: {
				text: 'Daily Rummy Rake'
			},
			xAxis: {
				title: {
					//text: 'Day	'
				},
				categories: d
			},
			yAxis: {
				title: {
					text: 'Amount'
				}

			},
			legend: {
				verticalAlign: 'bottom',
				//floating: true,
				backgroundColor: (Highcharts.theme && Highcharts.theme.background2) || 'white',
				borderColor: '#CCC',
				borderWidth: 1,
				shadow: false
			},
			plotOptions: {
				series: {
					borderWidth: 0,
					dataLabels: {
						enabled: false,
						format: 'Rs.{point.y:.2f}'
					}
				}
			},

			tooltip: {
				headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
				pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>Rs.{point.y:.2f}</b><br/>'
			},

			series: [{
				name: 'Amount',
				showInLegend: false,
				colorByPoint: true,
				data: mySeries
			}],
		});
	}	
}

