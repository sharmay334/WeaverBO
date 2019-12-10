/*
 * @author Nitish / Vaibhav
 * @date:29/03/2013
 * @desc: This js is use to create bubbletip and put the value of div in the blank space of bubble tip.
 */


var bindIndex = 0;
var map = new Array();

function wrapperObj(_options, _calc, _wrapper, _isHiding) {
	this.options = _options;
	this.calc = _calc;
	this.wrapper = _wrapper;
	this.isHiding = _isHiding;
}
$.fn
		.extend( {
			bubbletip : function(tip, options) {
				var _this, _tip, _options, _calc, _timeoutAnimate, _timeoutRefresh, _isActive, _isHiding, _wrapper, _bindIndex;
				_this = $(this);
				_tip = tip;
				//alert(_this.offset().top+"id"+_this.attr('id')+"_tip=");
				_bindIndex = bindIndex++; // for window.resize namespace
				// binding
				_options = {
					positionAt : 'element', // element | body | mouse
					positionAtElement : _this,
					offsetTop : 0,
					offsetLeft : 0,
					deltaPosition : 30,
					deltaDirection : 'up', // direction: up | down | left |
					// right
					animationDuration : 250,
					animationEasing : 'swing', // linear | swing
					bindShow : 'click', // mouseover | focus | click |
					// etc.
					bindHide : 'blur', // mouseout | blur | etc.
					delayShow : 0,
					delayHide : 500,
					calculateOnShow : false
				};
				if (options) {
					_options = $.extend(_options, options);
				}
				// calculated values
				_calc = {
					top : 0,
					left : 0,
					delta : 0,
					mouseTop : 0,
					mouseLeft : 0,
					tipHeight : 0,
					bindShow : (_options.bindShow + ' ').replace(/ +/g,
							'.bubbletip' + _bindIndex),
					bindHide : (_options.bindHide + ' ').replace(/ +/g,
							'.bubbletip' + _bindIndex)
				};
				_timeoutAnimate = null;
				_timeoutRefresh = null;
				_isActive = false;
				_isHiding = false;
//				if($('table.bubbletip #' + _tip.attr('id')).attr('id')==_tip.attr('id')){
//					$('table.bubbletip #' + _tip.attr('id')).closest('table.bubbletip').remove();
//				}
				//idValue=_this.attr('id');
				/*_wrapper = $('<table class="bubbletip" id="'+_this.attr('id')+'_bubbleTable" cellspacing="0" cellpadding="0" ><tbody><tr><td class="bt-topleft"></td><td class="bt-top"></td><td class="bt-topright"></td></tr><tr><td class="bt-left"></td><td class="bt-content"><div class="fieldError" id='+_this.attr('id')+"_errorDiv"+'></div>   </td><td class="bt-right"></td></tr><tr><td class="bt-bottomleft"></td><td><table class="bt-bottom" cellspacing="0" cellpadding="0"><tr><th></th><td><div></div></td><th></th></tr></table></td><td class="bt-bottomright"></td></tr></tbody></table>');*/
				_wrapper = $('<table class="bubbletip" id="'+_this.attr('id')+'_bubbleTable" cellspacing="0" cellpadding="0" ><tr><td><div class="bubble-div"><div class="fieldError" id='+_this.attr('id')+"_errorDiv"+'></div></div></td></tr></table>');
				_wrapper.appendTo('body');
				// move the tip element into the content section of the
				// wrapper
			//	$('.bt-content', _wrapper).append(_tip);
				// show the tip (in case it is hidden) so that we can
				// calculate its dimensions
				_tip.show();
				_wrapper.css('opacity', 1);
				//_Calculate(_options, _calc, _wrapper);
				_wrapper.hide();
				
				map[_this.attr('id')] = new wrapperObj(_options, _calc,
						_wrapper, _isHiding);
				//alert(_this.attr('id')+"===="+map[_this.attr('id')]);
//				/alert(map[_this.attr('id')]);
				return this;
			}
		});

function _Calculate(_options, _calc, _wrapper) {
	if (_options.positionAt.match(/^element$/i)) {
		var offset = _options.positionAtElement.offset();
		if (_options.deltaDirection.match(/^up$/i)) {
			_calc.top = offset.top + _options.offsetTop- _wrapper.outerHeight() ;
			//_calc.top = offset.top + _options.offsetTop-8 ;
			_calc.left = offset.left
					+ _options.offsetLeft
					+ ((_options.positionAtElement.outerWidth() - _wrapper
							.outerWidth()) / 2);
			_calc.delta = _options.deltaPosition;
		} else if (_options.deltaDirection.match(/^down$/i)) {
			_calc.top = offset.top + _options.positionAtElement.outerHeight()
					+ _options.offsetTop;
			_calc.left = offset.left
					+ _options.offsetLeft
					+ ((_options.positionAtElement.outerWidth() - _wrapper
							.outerWidth()) / 2);
			_calc.delta = -_options.deltaPosition;
		} else if (_options.deltaDirection.match(/^left$/i)) {
			_calc.top = offset.top
					+ _options.offsetTop
					+ ((_options.positionAtElement.outerHeight() - _wrapper
							.outerHeight()) / 2);
			_calc.left = offset.left + _options.offsetLeft
					- _wrapper.outerWidth();
			_calc.delta = _options.deltaPosition;
		} else if (_options.deltaDirection.match(/^right$/i)) {
			_calc.top = offset.top
					+ _options.offsetTop
					+ ((_options.positionAtElement.outerHeight() - _wrapper
							.outerHeight()) / 2);
			_calc.left = offset.left + _options.positionAtElement.outerWidth()
					+ _options.offsetLeft;
			_calc.delta = -_options.deltaPosition;
		}
	} else if (_options.positionAt.match(/^body$/i)) {
		if (_options.deltaDirection.match(/^up|left$/i)) {
			_calc.top = _options.offsetTop;
			_calc.left = _options.offsetLeft;
			// up or left
			_calc.delta = _options.deltaPosition;
		} else {
			if (_options.deltaDirection.match(/^down$/i)) {
				_calc.top = parseInt(_options.offsetTop
						+ _wrapper.outerHeight());
				_calc.left = _options.offsetLeft;
			} else {
				_calc.top = _options.offsetTop;
				_calc.left = parseInt(_options.offsetLeft
						+ _wrapper.outerWidth());
			}
			// down or right
			_calc.delta = -_options.deltaPosition;
		}
	} else if (_options.positionAt.match(/^mouse$/i)) {
		if (_options.deltaDirection.match(/^up|left$/i)) {
			if (_options.deltaDirection.match(/^up$/i)) {
				_calc.top = -(_options.offsetTop + _wrapper.outerHeight());
				_calc.left = _options.offsetLeft;
			} else if (_options.deltaDirection.match(/^left$/i)) {
				_calc.top = _options.offsetTop;
				_calc.left = -(_options.offsetLeft + _wrapper.outerWidth());
			}
			// up or left
			_calc.delta = _options.deltaPosition;
		} else {
			_calc.top = _options.offsetTop;
			_calc.left = _options.offsetLeft;
			// down or right
			_calc.delta = -_options.deltaPosition;
		}
	}
	// handle the wrapper (element|body) positioning
	if (_options.positionAt.match(/^element|body$/i)) {
		_wrapper.css( {
			'position' : 'absolute',
			'top' : _calc.top + 'px',
			'left' : _calc.left + 'px'
		});
	}
}

function _Show(_tip, _element) {
	
	//_tip=_element+"_errorDiv";
	if (typeof(_element.attr('applyscript')) != 'undefined' || (typeof(_element.attr('pattern')) != 'undefined' || typeof(_element.attr('min')) != 'undefined' || typeof(_element.attr('max')) != 'undefined' || typeof(_element.attr('minLength')) != 'undefined' || typeof(_element.attr('accept')) != 'undefined' ) ) {
	var _wrapperObj = map[_element.attr('id')];
	//alert(_wrapperObj);
	var _wrapper = _wrapperObj.wrapper;
	var _options = _wrapperObj.options;
	var _calc = _wrapperObj.calc;
	var _isHiding = _wrapperObj.isHiding;
	_Calculate(_options, _calc, _wrapper);
	//_calc.top=_calc.top+35;
	//$('.bt-content', _wrapper).append(_tip);
	_isActive = true;
	if (_isHiding) { // the tip is currently hiding; interrupt and start
		// showing again
		_wrapper.stop(true, false);
	}

	if (_options.positionAt.match(/^element|body$/i)) {
		if (_options.deltaDirection.match(/^up|down$/i)) {
			if (!_isHiding) {
				_wrapper.css('top', parseInt(_calc.top + _calc.delta) + 'px');
			}
			animation = {
				'top' : _calc.top + 'px'
			};
		}
	} else {
		if (_options.deltaDirection.match(/^up|down$/i)) {
			if (!_isHiding) {
				_calc.mouseTop = e.pageY + _calc.top;
				_wrapper.css( {
					'top' : parseInt(_calc.mouseTop + _calc.delta) + 'px',
					'left' : parseInt(e.pageX - (_wrapper.width() / 2)) + 'px'
				});
			}
			animation = {
				'top' : _calc.mouseTop + 'px'
			};
		}
	}
	_isHiding = false;
	_wrapper.show();
	
	if (($('table.bubbletip #' + _tip.attr('id')).html() == '<ul></ul>') || ($('table.bubbletip #' + _tip.attr('id')).html().length == 0))  {
		_wrapper.hide();
	}
	animation = $.extend(animation, {
		'opacity' : 1
	});
	_wrapper.animate(animation, _options.animationDuration,
			_options.animationEasing, function() {
				_wrapper.css('opacity', '');
				_isActive = true;

			});
	}
	
}
