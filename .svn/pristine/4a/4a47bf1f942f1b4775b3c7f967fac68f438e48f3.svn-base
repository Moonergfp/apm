/* jquery.easing.1.3.js*/
jQuery.easing['jswing'] = jQuery.easing['swing'];

jQuery.extend( jQuery.easing,
{
	def: 'easeOutQuad',
	swing: function (x, t, b, c, d) {
		//alert(jQuery.easing.default);
		return jQuery.easing[jQuery.easing.def](x, t, b, c, d);
	},
	easeInQuad: function (x, t, b, c, d) {
		return c*(t/=d)*t + b;
	},
	easeOutQuad: function (x, t, b, c, d) {
		return -c *(t/=d)*(t-2) + b;
	},
	easeInOutQuad: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t + b;
		return -c/2 * ((--t)*(t-2) - 1) + b;
	},
	easeInCubic: function (x, t, b, c, d) {
		return c*(t/=d)*t*t + b;
	},
	easeOutCubic: function (x, t, b, c, d) {
		return c*((t=t/d-1)*t*t + 1) + b;
	},
	easeInOutCubic: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t + b;
		return c/2*((t-=2)*t*t + 2) + b;
	},
	easeInQuart: function (x, t, b, c, d) {
		return c*(t/=d)*t*t*t + b;
	},
	easeOutQuart: function (x, t, b, c, d) {
		return -c * ((t=t/d-1)*t*t*t - 1) + b;
	},
	easeInOutQuart: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
		return -c/2 * ((t-=2)*t*t*t - 2) + b;
	},
	easeInQuint: function (x, t, b, c, d) {
		return c*(t/=d)*t*t*t*t + b;
	},
	easeOutQuint: function (x, t, b, c, d) {
		return c*((t=t/d-1)*t*t*t*t + 1) + b;
	},
	easeInOutQuint: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
		return c/2*((t-=2)*t*t*t*t + 2) + b;
	},
	easeInSine: function (x, t, b, c, d) {
		return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
	},
	easeOutSine: function (x, t, b, c, d) {
		return c * Math.sin(t/d * (Math.PI/2)) + b;
	},
	easeInOutSine: function (x, t, b, c, d) {
		return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
	},
	easeInExpo: function (x, t, b, c, d) {
		return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b;
	},
	easeOutExpo: function (x, t, b, c, d) {
		return (t==d) ? b+c : c * (-Math.pow(2, -10 * t/d) + 1) + b;
	},
	easeInOutExpo: function (x, t, b, c, d) {
		if (t==0) return b;
		if (t==d) return b+c;
		if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
		return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
	},
	easeInCirc: function (x, t, b, c, d) {
		return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
	},
	easeOutCirc: function (x, t, b, c, d) {
		return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
	},
	easeInOutCirc: function (x, t, b, c, d) {
		if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
		return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
	},
	easeInElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
	},
	easeOutElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		return a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b;
	},
	easeInOutElastic: function (x, t, b, c, d) {
		var s=1.70158;var p=0;var a=c;
		if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
		if (a < Math.abs(c)) { a=c; var s=p/4; }
		else var s = p/(2*Math.PI) * Math.asin (c/a);
		if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
	},
	easeInBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158;
		return c*(t/=d)*t*((s+1)*t - s) + b;
	},
	easeOutBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158;
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
	},
	easeInOutBack: function (x, t, b, c, d, s) {
		if (s == undefined) s = 1.70158; 
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
	},
	easeInBounce: function (x, t, b, c, d) {
		return c - jQuery.easing.easeOutBounce (x, d-t, 0, c, d) + b;
	},
	easeOutBounce: function (x, t, b, c, d) {
		if ((t/=d) < (1/2.75)) {
			return c*(7.5625*t*t) + b;
		} else if (t < (2/2.75)) {
			return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
		} else if (t < (2.5/2.75)) {
			return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
		} else {
			return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
		}
	},
	easeInOutBounce: function (x, t, b, c, d) {
		if (t < d/2) return jQuery.easing.easeInBounce (x, t*2, 0, c, d) * .5 + b;
		return jQuery.easing.easeOutBounce (x, t*2-d, 0, c, d) * .5 + c*.5 + b;
	}
});

//animate.enhanced
(function(d,J,K){function P(a,b,d,l,j,h,c,n,q){var t=!1;c=!0===c&&!0===n;b=b||{};b.original||(b.original={},t=!0);b.properties=b.properties||{};b.secondary=b.secondary||{};n=b.meta;for(var k=b.original,x=b.properties,Q=b.secondary,D=r.length-1;0<=D;D--){var F=r[D]+"transition-property",y=r[D]+"transition-duration",e=r[D]+"transition-timing-function";d=c?r[D]+"transform":d;t&&(k[F]=a.css(F)||"",k[y]=a.css(y)||"",k[e]=a.css(e)||"");Q[d]=c?!0===q||!0===G&&!1!==q&&L?"translate3d("+n.left+"px, "+n.top+
"px, 0)":"translate("+n.left+"px,"+n.top+"px)":h;x[F]=(x[F]?x[F]+",":"")+d;x[y]=(x[y]?x[y]+",":"")+l+"ms";x[e]=(x[e]?x[e]+",":"")+j}return b}function B(a){for(var b in a)return!1;return!0}function R(a){a=a.toUpperCase();var b={LI:"list-item",TR:"table-row",TD:"table-cell",TH:"table-cell",CAPTION:"table-caption",COL:"table-column",COLGROUP:"table-column-group",TFOOT:"table-footer-group",THEAD:"table-header-group",TBODY:"table-row-group"};return"string"==typeof b[a]?b[a]:"block"}function H(a){return parseFloat(a.replace(a.match(/\D+$/),
""))}function M(a){var b=!0;a.each(function(a,d){return b=b&&d.ownerDocument});return b}var S="top right bottom left opacity height width".split(" "),I=["top","right","bottom","left"],r=["-webkit-","-moz-","-o-",""],T=["avoidTransforms","useTranslate3d","leaveTransforms"],U=/^([+-]=)?([\d+-.]+)(.*)$/,V=/([A-Z])/g,W={secondary:{},meta:{top:0,right:0,bottom:0,left:0}},N=null,C=!1,z=(document.body||document.documentElement).style,O=void 0!==z.WebkitTransition||void 0!==z.MozTransition||void 0!==z.OTransition||
void 0!==z.transition,L="WebKitCSSMatrix"in window&&"m11"in new WebKitCSSMatrix,G=L;d.expr&&d.expr.filters&&(N=d.expr.filters.animated,d.expr.filters.animated=function(a){return d(a).data("events")&&d(a).data("events")["webkitTransitionEnd oTransitionEnd transitionend"]?!0:N.call(this,a)});d.extend({toggle3DByDefault:function(){return G=!G},toggleDisabledByDefault:function(){return C=!C},setDisabledByDefault:function(a){return C=a}});d.fn.translation=function(){if(!this[0])return null;var a=window.getComputedStyle(this[0],
null),d={x:0,y:0};if(a)for(var p=r.length-1;0<=p;p--){var l=a.getPropertyValue(r[p]+"transform");if(l&&/matrix/i.test(l)){a=l.replace(/^matrix\(/i,"").split(/, |\)$/g);d={x:parseInt(a[4],10),y:parseInt(a[5],10)};break}}return d};d.fn.animate=function(a,b,p,l){a=a||{};var j=!("undefined"!==typeof a.bottom||"undefined"!==typeof a.right),h=d.speed(b,p,l),c=this,n=0,q=function(){n--;0===n&&"function"===typeof h.complete&&h.complete.apply(c,arguments)},t;if(!(t=!0===("undefined"!==typeof a.avoidCSSTransitions?
a.avoidCSSTransitions:C)))if(!(t=!O))if(!(t=B(a))){var k;a:{for(k in a)if(("width"==k||"height"==k)&&("show"==a[k]||"hide"==a[k]||"toggle"==a[k])){k=!0;break a}k=!1}t=k||0>=h.duration}return t?J.apply(this,arguments):this[!0===h.queue?"queue":"each"](function(){var b=d(this),c=d.extend({},h),l=function(c){var g=b.data("jQe")||{original:{}},f={};if(2==c.eventPhase){if(!0!==a.leaveTransforms){for(c=r.length-1;0<=c;c--)f[r[c]+"transform"]="";if(j&&"undefined"!==typeof g.meta){c=0;for(var e;e=I[c];++c)f[e]=
g.meta[e+"_o"]+"px",d(this).css(e,f[e])}}b.unbind("webkitTransitionEnd oTransitionEnd transitionend").css(g.original).css(f).data("jQe",null);"hide"===a.opacity&&b.css({display:"none",opacity:""});q.call(this)}},k={bounce:"cubic-bezier(0.0, 0.35, .5, 1.3)",linear:"linear",swing:"ease-in-out",easeInQuad:"cubic-bezier(0.550, 0.085, 0.680, 0.530)",easeInCubic:"cubic-bezier(0.550, 0.055, 0.675, 0.190)",easeInQuart:"cubic-bezier(0.895, 0.030, 0.685, 0.220)",easeInQuint:"cubic-bezier(0.755, 0.050, 0.855, 0.060)",
easeInSine:"cubic-bezier(0.470, 0.000, 0.745, 0.715)",easeInExpo:"cubic-bezier(0.950, 0.050, 0.795, 0.035)",easeInCirc:"cubic-bezier(0.600, 0.040, 0.980, 0.335)",easeInBack:"cubic-bezier(0.600, -0.280, 0.735, 0.045)",easeOutQuad:"cubic-bezier(0.250, 0.460, 0.450, 0.940)",easeOutCubic:"cubic-bezier(0.215, 0.610, 0.355, 1.000)",easeOutQuart:"cubic-bezier(0.165, 0.840, 0.440, 1.000)",easeOutQuint:"cubic-bezier(0.230, 1.000, 0.320, 1.000)",easeOutSine:"cubic-bezier(0.390, 0.575, 0.565, 1.000)",easeOutExpo:"cubic-bezier(0.190, 1.000, 0.220, 1.000)",
easeOutCirc:"cubic-bezier(0.075, 0.820, 0.165, 1.000)",easeOutBack:"cubic-bezier(0.175, 0.885, 0.320, 1.275)",easeInOutQuad:"cubic-bezier(0.455, 0.030, 0.515, 0.955)",easeInOutCubic:"cubic-bezier(0.645, 0.045, 0.355, 1.000)",easeInOutQuart:"cubic-bezier(0.770, 0.000, 0.175, 1.000)",easeInOutQuint:"cubic-bezier(0.860, 0.000, 0.070, 1.000)",easeInOutSine:"cubic-bezier(0.445, 0.050, 0.550, 0.950)",easeInOutExpo:"cubic-bezier(1.000, 0.000, 0.000, 1.000)",easeInOutCirc:"cubic-bezier(0.785, 0.135, 0.150, 0.860)",
easeInOutBack:"cubic-bezier(0.680, -0.550, 0.265, 1.550)"},y={},k=k[c.easing||"swing"]?k[c.easing||"swing"]:c.easing||"swing",e;for(e in a)if(-1===d.inArray(e,T)){var p=-1<d.inArray(e,I),m;var g=b,w=a[e],u=e,s=p&&!0!==a.avoidTransforms;if("d"==u)m=void 0;else if(M(g)){var f=U.exec(w);m="auto"===g.css(u)?0:g.css(u);m="string"==typeof m?H(m):m;"string"==typeof w&&H(w);var s=!0===s?0:m,t=g.is(":hidden"),v=g.translation();"left"==u&&(s=parseInt(m,10)+v.x);"right"==u&&(s=parseInt(m,10)+v.x);"top"==u&&
(s=parseInt(m,10)+v.y);"bottom"==u&&(s=parseInt(m,10)+v.y);!f&&"show"==w?(s=1,t&&g.css({display:R(g.context.tagName),opacity:0})):!f&&"hide"==w&&(s=0);f?(g=parseFloat(f[2]),f[1]&&(g=("-="===f[1]?-1:1)*g+parseInt(s,10)),m=g):m=s}else m=void 0;f=e;g=m;w=b;if(M(w)){u=-1<d.inArray(f,S);if(("width"==f||"height"==f||"opacity"==f)&&parseFloat(g)===parseFloat(w.css(f)))u=!1;f=u}else f=!1;if(f){var f=b,g=e,w=c.duration,u=k,p=p&&!0!==a.avoidTransforms,s=j,t=a.useTranslate3d,v=(v=f.data("jQe"))&&!B(v)?v:d.extend(!0,
{},W),A=m;if(-1<d.inArray(g,I)){var E=v.meta,C=H(f.css(g))||0,z=g+"_o",A=m-C;E[g]=A;E[z]="auto"==f.css(g)?0+A:C+A||0;v.meta=E;s&&0===A&&(A=0-E[z],E[g]=A,E[z]=0)}f.data("jQe",P(f,v,g,w,u,A,p,s,t))}else y[e]=a[e]}b.unbind("webkitTransitionEnd oTransitionEnd transitionend");if((e=b.data("jQe"))&&!B(e)&&!B(e.secondary)){n++;b.css(e.properties);var G=e.secondary;setTimeout(function(){b.bind("webkitTransitionEnd oTransitionEnd transitionend",l).css(G)})}else c.queue=!1;B(y)||(n++,J.apply(b,[y,{duration:c.duration,
easing:d.easing[c.easing]?c.easing:d.easing.swing?"swing":"linear",complete:q,queue:c.queue}]));return!0})};d.fn.animate.defaults={};d.fn.stop=function(a,b,p){if(!O)return K.apply(this,[a,b]);a&&this.queue([]);this.each(function(){var l=d(this),j=l.data("jQe");if(j&&!B(j)){var h,c={};if(b){if(c=j.secondary,!p&&void 0!==typeof j.meta.left_o||void 0!==typeof j.meta.top_o){c.left=void 0!==typeof j.meta.left_o?j.meta.left_o:"auto";c.top=void 0!==typeof j.meta.top_o?j.meta.top_o:"auto";for(h=r.length-
1;0<=h;h--)c[r[h]+"transform"]=""}}else if(!B(j.secondary)){var n=window.getComputedStyle(l[0],null);if(n)for(var q in j.secondary)if(j.secondary.hasOwnProperty(q)&&(q=q.replace(V,"-$1").toLowerCase(),c[q]=n.getPropertyValue(q),!p&&/matrix/i.test(c[q]))){h=c[q].replace(/^matrix\(/i,"").split(/, |\)$/g);c.left=parseFloat(h[4])+parseFloat(l.css("left"))+"px"||"auto";c.top=parseFloat(h[5])+parseFloat(l.css("top"))+"px"||"auto";for(h=r.length-1;0<=h;h--)c[r[h]+"transform"]=""}}l.unbind("webkitTransitionEnd oTransitionEnd transitionend");
l.css(j.original).css(c).data("jQe",null)}else K.apply(l,[a,b])});return this}})(jQuery,jQuery.fn.animate,jQuery.fn.stop);

//
//super slides
/*! Superslides - v0.6.3-wip - 2013-08-01
* https://github.com/nicinabox/superslides
* Copyright (c) 2013 Nic Aitch; Licensed MIT */
(function(window, $) {

var Superslides, plugin = 'superslides';

Superslides = function(el, options) {
  this.options = $.extend({
    play: false,
    animation_speed: 600,
    animation_easing: 'swing',
    animation: 'slide',
    inherit_width_from: window,
    inherit_height_from: window,
    max_height: 10000000000,
    pagination: true,
    hashchange: false,
    scrollable: true,
    elements: {
      preserve: '.preserve',
      nav: '.slides-navigation',
      container: '.slides-container',
      pagination: '.slides-pagination'
    }
  }, options);

  var that       = this,
      $control   = $('<div>', { "class": 'slides-control' }),
      multiplier = 1;

  this.$el        = $(el);
  this.$container = this.$el.find(this.options.elements.container);

  // Private Methods
  var initialize = function() {
    multiplier = that._findMultiplier();

    that.$el.on('click', that.options.elements.nav + " a", function(e) {
      e.preventDefault();

      that.stop();
      if ($(this).hasClass('next')) {
        that.animate('next', function() {
          that.start();
        });
      } else {
        that.animate('prev', function() {
          that.start();
        });
      }
    });

    $(document).on('keyup', function(e) {
      if (e.keyCode === 37) {
        that.animate('prev');
      }
      if (e.keyCode === 39) {
        that.animate('next');
      }
    });

    $(window).on('resize', function() {
      setTimeout(function() {
        var $children = that.$container.children();

        that.width  = that._findWidth();
        that.height = that._findHeight();

        $children.css({
          width: that.width,
          left: that.width
        });

        that.css.containers();
        that.css.images();
      }, 10);
    });

    that.options.hashchange && $(window).on('hashchange', function() {
      var hash = that._parseHash(), index;

      index = that._upcomingSlide(hash);

      if (index >= 0 && index !== that.current) {
        that.animate(index);
      }
    });

    that.pagination._events();

    that.start();
    
    
    return that;
  };

var css = {
  containers: function() {
    if (that.init) {
      that.$el.css({
        height: that.height
      });

      that.$control.css({
        width: that.width * multiplier,
        left: -that.width
      });

      that.$container.css({

      });
    } else {
      $('body').css({
        margin: 0
      });

      that.$el.css({
        position: 'relative',
        overflow: 'hidden',
        width: '100%',
        height: that.height
      });

      that.$control.css({
        position: 'relative',
        transform: 'translate3d(0)',
        height: '100%',
        width: that.width * multiplier,
        left: -that.width
      });

      that.$container.css({
        display: 'none',
        margin: '0',
        padding: '0',
        listStyle: 'none',
        position: 'relative',
        height: '100%'
      });
    }

    if (that.size() === 1) {
      that.$el.find(that.options.elements.nav).hide();
    }
  },
  images: function() {
    var $images = that.$container.find('img')
                                 .not(that.options.elements.preserve);

    $images.removeAttr('width').removeAttr('height')
      .css({
        "-webkit-backface-visibility": 'hidden',
        "-ms-interpolation-mode": 'bicubic',
        "position": 'absolute',
        "left": '0',
        "top": '0',
        "z-index": '-1',
        "max-width": 'none'
      });

    $images.each(function() {
      var image_aspect_ratio = that.image._aspectRatio(this),
          image = this;

      if (!$.data(this, 'processed')) {
        var img = new Image();
        img.onload = function() {
          that.image._scale(image, image_aspect_ratio);
          that.image._center(image, image_aspect_ratio);
          $.data(image, 'processed', true);
        };
        img.src = this.src;

      } else {
        that.image._scale(image, image_aspect_ratio);
        that.image._center(image, image_aspect_ratio);
      }
    });
  },
  children: function() {
    var $children = that.$container.children();

    if ($children.is('img')) {
      $children.each(function() {
        if ($(this).is('img')) {
          $(this).wrap('<div>');

          // move id attribute
          var id = $(this).attr('id');
          $(this).removeAttr('id');
          $(this).parent().attr('id', id);
        }
      });

      $children = that.$container.children();
    }

    if (!that.init) {
      $children.css({
        display: 'none',
        left: that.width * 2
      });
    }

    $children.css({
      position: 'absolute',
      overflow: 'hidden',
      height: '100%',
      width: that.width,
      top: 0,
      zIndex: 0
    });

  }
};

var fx = {
  slide: function(orientation, complete) {
    var $children = that.$container.children(),
        $target   = $children.eq(orientation.upcoming_slide);

    $target.css({
      left: orientation.upcoming_position,
      display: 'block'
    });

    that.$control.animate({
      left: orientation.offset
    },
    that.options.animation_speed,
    that.options.animation_easing,
    function() {
      if (that.size() > 1) {
        that.$control.css({
          left: -that.width
        });

        $children.eq(orientation.upcoming_slide).css({
          left: that.width,
          zIndex: 2
        });

        if (orientation.outgoing_slide >= 0) {
          $children.eq(orientation.outgoing_slide).css({
            left: that.width,
            display: 'none',
            zIndex: 0
          });
        }
      }

      complete();
    });
  },
  fade: function(orientation, complete) {
    var that = this,
        $children = that.$container.children(),
        $outgoing = $children.eq(orientation.outgoing_slide),
        $target = $children.eq(orientation.upcoming_slide);

    $target.css({
      left: this.width,
      opacity: 1,
      display: 'block'
    });

    if (orientation.outgoing_slide >= 0) {
      $outgoing.animate({
        opacity: 0
      },
      that.options.animation_speed,
      that.options.animation_easing,
      function() {
        if (that.size() > 1) {
          $children.eq(orientation.upcoming_slide).css({
            zIndex: 2
          });

          if (orientation.outgoing_slide >= 0) {
            $children.eq(orientation.outgoing_slide).css({
              opacity: 1,
              display: 'none',
              zIndex: 0
            });
          }
        }

        complete();
      });
    } else {
      $target.css({
        zIndex: 2
      });
      complete();
    }
  }
};

fx = $.extend(fx, $.fn.superslides.fx);

var image = {
  _centerY: function(image) {
    var $img = $(image);

    $img.css({
      top: (that.height - $img.height()) / 2
    });
  },
  _centerX: function(image) {
    var $img = $(image);

    $img.css({
      left: (that.width - $img.width()) / 2
    });
  },
  _center: function(image) {
    that.image._centerX(image);
    that.image._centerY(image);
  },
  _aspectRatio: function(image) {
    if (!image.naturalHeight && !image.naturalWidth) {
      var img = new Image();
      img.src = image.src;
      image.naturalHeight = img.height;
      image.naturalWidth = img.width;
    }

    return image.naturalHeight / image.naturalWidth;
  },
  _scale: function(image, image_aspect_ratio) {
    image_aspect_ratio = image_aspect_ratio || that.image._aspectRatio(image);

    var container_aspect_ratio = that.height / that.width,
        $img = $(image);

    if (container_aspect_ratio > image_aspect_ratio) {
      $img.css({
        height: that.height,
        width: that.height / image_aspect_ratio
      });

    } else {
      $img.css({
        height: that.width * image_aspect_ratio,
        width: that.width
      });
    }
  }
};

var pagination = {
  _setCurrent: function(i) {
    if (!that.$pagination) { return; }

    var $pagination_children = that.$pagination.children();

    $pagination_children.removeClass('current');
    $pagination_children.eq(i)
      .addClass('current');
  },
  _addItem: function(i) {
    var slide_number = i + 1,
        href = slide_number,
        $slide = that.$container.children().eq(i),
        slide_id = $slide.attr('id');

    if (slide_id) {
      href = slide_id;
    }

    var $item = $("<a>", {
      'href': "#" + href,
      'text': href
    });

    $item.appendTo(that.$pagination);
  },
  _setup: function() {
    if (!that.options.pagination || that.size() === 1) { return; }

    var $pagination = $("<nav>", {
      'class': that.options.elements.pagination.replace(/^\./, '')
    });

    that.$pagination = $pagination.appendTo(that.$el);

    for (var i = 0; i < that.size(); i++) {
      that.pagination._addItem(i);
    }
  },
  _events: function() {
    that.$el.on('click', that.options.elements.pagination + ' a', function(e) {
      e.preventDefault();

      var hash  = that._parseHash(this.hash), index;
      index = that._upcomingSlide(hash, true);

      if (index !== that.current) {
        that.animate(index, function() {
          that.start();
        });
      }
    });
  }
};

  this.css = css;
  this.image = image;
  this.pagination = pagination;
  this.fx = fx;
  this.animation = this.fx[this.options.animation];

  this.$control = this.$container.wrap($control).parent('.slides-control');

  that._findPositions();
  that.width  = that._findWidth();
  that.height = that._findHeight();

  this.css.children();
  this.css.containers();
  this.css.images();
  this.pagination._setup();
  	
  return initialize();
};

Superslides.prototype = {
  _findWidth: function() {
    return $(this.options.inherit_width_from).width();
  },
  _findHeight: function() {
    return Math.min($(this.options.inherit_height_from).height(), this.options.max_height);
  },

  _findMultiplier: function() {
    return this.size() === 1 ? 1 : 3;
  },

  _upcomingSlide: function(direction, from_hash_change) {
    if (from_hash_change && !isNaN(direction)) {
      direction = direction - 1;
    }

    if ((/next/).test(direction)) {
      return this._nextInDom();

    } else if ((/prev/).test(direction)) {
      return this._prevInDom();

    } else if ((/\d/).test(direction)) {
      return +direction;

    } else if (direction && (/\w/).test(direction)) {
      var index = this._findSlideById(direction);
      if (index >= 0) {
        return index;
      } else {
        return 0;
      }

    } else {
      return 0;
    }
  },

  _findSlideById: function(id) {
    return this.$container.find('#' + id).index();
  },

  _findPositions: function(current, thisRef) {
    thisRef = thisRef || this;

    if (current === undefined) {
      current = -1;
    }

    thisRef.current = current;
    thisRef.next    = thisRef._nextInDom();
    thisRef.prev    = thisRef._prevInDom();
  },

  _nextInDom: function() {
    var index = this.current + 1;

    if (index === this.size()) {
      index = 0;
    }

    return index;
  },

  _prevInDom: function() {
    var index = this.current - 1;

    if (index < 0) {
      index = this.size() - 1;
    }

    return index;
  },

  _parseHash: function(hash) {
    hash = hash || window.location.hash;
    hash = hash.replace(/^#/, '');

    if (hash && !isNaN(+hash)) {
      hash = +hash;
    }

    return hash;
  },

  size: function() {
    return this.$container.children().length;
  },

  destroy: function() {
    return this.$el.removeData();
  },

  update: function() {
    this.css.children();
    this.css.containers();
    this.css.images();

    this.pagination._addItem(this.size());

    this._findPositions(this.current);
    this.$el.trigger('updated.slides');
  },

  stop: function() {
    clearInterval(this.play_id);
    delete this.play_id;

    this.$el.trigger('stopped.slides');
  },

  start: function() {
    var that = this;

    if (that.options.hashchange) {
      $(window).trigger('hashchange');
    } else {
      this.animate();
    }

    if (this.options.play) {
      if (this.play_id) {
        this.stop();
      }

      this.play_id = setInterval(function() {
        that.animate();
      }, this.options.play);
    }

    this.$el.trigger('started.slides');
  },

  animate: function(direction, userCallback) {
    var that = this,
        orientation = {};

    if (this.animating) {
      return;
    }

    this.animating = true;

    if (direction === undefined) {
      direction = 'next';
    }

    orientation.upcoming_slide = this._upcomingSlide(direction);

    if (orientation.upcoming_slide >= this.size()) {
      return;
    }

    orientation.outgoing_slide    = this.current;
    orientation.upcoming_position = this.width * 2;
    orientation.offset            = -orientation.upcoming_position;

    if (direction === 'prev' || direction < orientation.outgoing_slide) {
      orientation.upcoming_position = 0;
      orientation.offset            = 0;
    }

    if (that.size() > 1) {
      that.pagination._setCurrent(orientation.upcoming_slide);
    }

    if (that.options.hashchange) {
      var hash = orientation.upcoming_slide + 1,
          id = that.$container.children(':eq(' + orientation.upcoming_slide + ')').attr('id');

      if (id) {
        window.location.hash = id;
      } else {
        window.location.hash = hash;
      }
    }

    that.$el.trigger('animating.slides', [orientation]);

    that.animation(orientation, function() {
      that._findPositions(orientation.upcoming_slide, that);

      if (typeof userCallback === 'function') {
        userCallback();
      }

      that.animating = false;
      that.$el.trigger('animated.slides');

      if (!that.init) {
        that.$el.trigger('init.slides');
        that.init = true;
        that.$container.fadeIn('fast');
      }
    });
  }
};

// jQuery plugin definition

$.fn[plugin] = function(option, args) {
  var result = [];

  this.each(function() {
    var $this, data, options;

    $this = $(this);
    data = $this.data(plugin);
    options = typeof option === 'object' && option;

    if (!data) {
      result = $this.data(plugin, (data = new Superslides(this, options)));
    }

    if (typeof option === "string") {
      result = data[option];
      if (typeof result === 'function') {
        return result = result.call(data, args);
      }
    }
  });

  return result;
};

$.fn[plugin].fx = {};

})(this, jQuery);
//

//onepage-scroll
/* ===========================================================
 * jquery-onepage-scroll.js v1.2
 * ===========================================================
 * Copyright 2013 Pete Rojwongsuriya.
 * http://www.thepetedesign.com
 *
 * Create an Apple-like website that let user scroll
 * one page at a time
 *
 * Credit: Eike Send for the awesome swipe event
 * https://github.com/peachananr/onepage-scroll
 * 
 * License: GPL v3
 *
 * ========================================================== */

!function($){
  
  var defaults = {
    sectionContainer: "section",
    easing: "ease",
    animationTime: 1000,
    pagination: true,
    updateURL: false,
    keyboard: true,
    beforeMove: null,
    afterMove: null,
    loop: false,
    responsiveFallback: false
	};
	
	/*------------------------------------------------*/
	/*  Credit: Eike Send for the awesome swipe event */    
	/*------------------------------------------------*/
	
	$.fn.swipeEvents = function() {
      return this.each(function() {

        var startX,
            startY,
            $this = $(this);

        $this.bind('touchstart', touchstart);

        function touchstart(event) {
          var touches = event.originalEvent.touches;
          if (touches && touches.length) {
            startX = touches[0].pageX;
            startY = touches[0].pageY;
            $this.bind('touchmove', touchmove);
          }
        }

        function touchmove(event) {
          var touches = event.originalEvent.touches;
          if (touches && touches.length) {
            var deltaX = startX - touches[0].pageX;
            var deltaY = startY - touches[0].pageY;

            if (deltaX >= 50) {
              $this.trigger("swipeLeft");
            }
            if (deltaX <= -50) {
              $this.trigger("swipeRight");
            }
            if (deltaY >= 50) {
              $this.trigger("swipeUp");
            }
            if (deltaY <= -50) {
              $this.trigger("swipeDown");
            }
            if (Math.abs(deltaX) >= 50 || Math.abs(deltaY) >= 50) {
              $this.unbind('touchmove', touchmove);
            }
          }
        }

      });
    };
	

  $.fn.onepage_scroll = function(options){
    var settings = $.extend({}, defaults, options),
        el = $(this),
        sections = $(settings.sectionContainer);
        total = sections.length,
        status = "off",
        topPos = 0,
        lastAnimation = 0,
        quietPeriod = 500,
        paginationList = "";
    
    $.fn.transformPage = function(settings, pos, index) {
    	var self = $(this);
    	var body = $("body");
    	var win = $(window);
    	var scrollTop = Math.max(body.scrollTop(),win.scrollTop());
    	var height = body.height();
    	
    	var winHeight = win.height();
		
		var maxScroll = height - winHeight;
		var scrollDelta = Math.min(maxScroll, next.offset().top);
		
		index1 = next.attr("data-index") - 1;
		self.trigger("slideStart", [index1]);
		
		$("body, html").animate({scrollTop: scrollDelta},settings.animationTime, function(){
			self.trigger("slideEnd", [index1]);
		});
      /*
      $(this).css({
              "-webkit-transform": "transla		te3d(0, " + pos + "%, 0)", 
              "-webkit-transition": "all " + settings.animationTime + "ms " + settings.easing,
              "-moz-transform": "translate3d(0, " + pos + "%, 0)", 
              "-moz-transition": "all " + settings.animationTime + "ms " + settings.easing,
              "-ms-transform": "translate3d(0, " + pos + "%, 0)", 
              "-ms-transition": "all " + settings.animationTime + "ms " + settings.easing,
              "transform": "translate3d(0, " + pos + "%, 0)", 
              "transition": "all " + settings.animationTime + "ms " + settings.easing
            });*/
      
      $(this).one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend', function(e) {
        if (typeof settings.afterMove == 'function') settings.afterMove(index);
      });
    };
    
    $.fn.moveDown = function() {
      var el = $(this);
      index = $(settings.sectionContainer +".active").data("index");
      current = $(settings.sectionContainer + "[data-index='" + index + "']");
      next = $(settings.sectionContainer + "[data-index='" + (index + 1) + "']");
      if(next.length < 1) {
        if (settings.loop == true) {
          pos = 0;
          next = $(settings.sectionContainer + "[data-index='1']");
        } else {
          return;
        }
        
      }else {
        pos = (index * 100) * -1;
      }
      if (typeof settings.beforeMove == 'function') settings.beforeMove( current.data("index"));
      current.removeClass("active");
      next.addClass("active");
      if(settings.pagination == true) {
        $(".onepage-pagination li a" + "[data-index='" + index + "']").removeClass("active");
        $(".onepage-pagination li a" + "[data-index='" + next.data("index") + "']").addClass("active");
      }
      
      $("body")[0].className = $("body")[0].className.replace(/\bviewing-page-\d.*?\b/g, '');
      $("body").addClass("viewing-page-"+next.data("index"));
      
      if (history.replaceState && settings.updateURL == true) {
        var href = window.location.href.substr(0,window.location.href.indexOf('#')) + "#" + (index + 1);
        history.pushState( {}, document.title, href );
      }   
      el.transformPage(settings, pos, index);
    };
    
    $.fn.moveUp = function() {
      var el = $(this);
      index = $(settings.sectionContainer +".active").data("index");
      current = $(settings.sectionContainer + "[data-index='" + index + "']");
      next = $(settings.sectionContainer + "[data-index='" + (index - 1) + "']");
      
      if(next.length < 1) {
        if (settings.loop == true) {
          pos = ((total - 1) * 100) * -1;
          next = $(settings.sectionContainer + "[data-index='"+total+"']");
        }
        else {
          return;
        }
      }else {
        pos = ((next.data("index") - 1) * 100) * -1;
      }
      if (typeof settings.beforeMove == 'function') settings.beforeMove(current.data("index"));
      current.removeClass("active");
      next.addClass("active");
      if(settings.pagination == true) {
        $(".onepage-pagination li a" + "[data-index='" + index + "']").removeClass("active");
        $(".onepage-pagination li a" + "[data-index='" + next.data("index") + "']").addClass("active");
      }
      $("body")[0].className = $("body")[0].className.replace(/\bviewing-page-\d.*?\b/g, '');
      $("body").addClass("viewing-page-"+next.data("index"));
      
      if (history.replaceState && settings.updateURL == true) {
        var href = window.location.href.substr(0,window.location.href.indexOf('#')) + "#" + (index - 1);
        history.pushState( {}, document.title, href );
      }
      el.transformPage(settings, pos, index);
    };
    
    $.fn.moveTo = function(page_index) {
      current = $(settings.sectionContainer + ".active");
      next = $(settings.sectionContainer + "[data-index='" + (page_index) + "']");
      if(next.length > 0) {
        current.removeClass("active");
        next.addClass("active");
        $(".onepage-pagination li a" + ".active").removeClass("active");
        $(".onepage-pagination li a" + "[data-index='" + (page_index) + "']").addClass("active");
        $("body")[0].className = $("body")[0].className.replace(/\bviewing-page-\d.*?\b/g, '');
        $("body").addClass("viewing-page-"+next.data("index"));
        
        pos = ((page_index - 1) * 100) * -1;
        el.transformPage(settings, pos, page_index);
        if (settings.updateURL == false) return false;
      }
    };
    
    function responsive() {
      if ($(window).width() < settings.responsiveFallback) {
        $("body").addClass("disabled-onepage-scroll");
        $(document).unbind('mousewheel DOMMouseScroll');
        el.swipeEvents().unbind("swipeDown swipeUp");
      } else {
        if($("body").hasClass("disabled-onepage-scroll")) {
          $("body").removeClass("disabled-onepage-scroll");
          $("html, body, .wrapper").animate({ scrollTop: 0 }, "fast");
        }
        
        
        el.swipeEvents().bind("swipeDown",  function(event){ 
          if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
          el.moveUp();
        }).bind("swipeUp", function(event){ 
          if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
          el.moveDown();
        });
        
        $(document).bind('mousewheel DOMMouseScroll', function(event) {
          event.preventDefault();
          var delta = event.originalEvent.wheelDelta || -event.originalEvent.detail;
          init_scroll(event, delta);
        });
      }
    }
    
    
    function init_scroll(event, delta) {
        deltaOfInterest = delta;
        var timeNow = new Date().getTime();
        // Cancel scroll if currently animating or within quiet period
        if(timeNow - lastAnimation < quietPeriod + settings.animationTime) {
            event.preventDefault();
            return;
        }

        if (deltaOfInterest < 0) {
          el.moveDown();
        } else {
          el.moveUp();
        }
        lastAnimation = timeNow;
    }
    
    // Prepare everything before binding wheel scroll
    
    el.addClass("onepage-wrapper").css("position","relative");
    $.each( sections, function(i) {
      $(this)/*
      .css({
              position: "absolute",
              top: topPos + "%"
            })*/
      .addClass("section").attr("data-index", i+1);
      topPos = topPos + 100;
      if(settings.pagination == true) {
        paginationList += "<li "+ (i == 0 ? 'id= "js_page_one_nav_home"' : "")  + "><a data-index='"+(i+1)+"' href='#" + (i+1) + "'></a></li>";
      }
    });
    
    el.swipeEvents().bind("swipeDown",  function(event){ 
      if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
      el.moveUp();
    }).bind("swipeUp", function(event){ 
      if (!$("body").hasClass("disabled-onepage-scroll")) event.preventDefault();
      el.moveDown(); 
    });
    
    // Create Pagination and Display Them
    if(settings.pagination == true) {
      $("<ul class='onepage-pagination'>" + paginationList + "</ul>").prependTo("body");
      posTop = (el.find(".onepage-pagination").height() / 2) * -1;
      el.find(".onepage-pagination").css("margin-top", posTop);
    }
    
    //disable auto hash detect
    //modified by wangfeng at 2014/01/09
    if(false && window.location.hash != "" && window.location.hash != "#1") {
      init_index =  window.location.hash.replace("#", "");
      $(settings.sectionContainer + "[data-index='" + init_index + "']").addClass("active");
      $("body").addClass("viewing-page-"+ init_index);
      if(settings.pagination == true) $(".onepage-pagination li a" + "[data-index='" + init_index + "']").addClass("active");
      
      next = $(settings.sectionContainer + "[data-index='" + (init_index) + "']");
      if(next) {
        next.addClass("active");
        if(settings.pagination == true) $(".onepage-pagination li a" + "[data-index='" + (init_index) + "']").addClass("active");
        $("body")[0].className = $("body")[0].className.replace(/\bviewing-page-\d.*?\b/g, '');
        $("body").addClass("viewing-page-"+next.data("index"));
        if (history.replaceState && settings.updateURL == true) {
          var href = window.location.href.substr(0,window.location.href.indexOf('#')) + "#" + (init_index);
          history.pushState( {}, document.title, href );
        }
      }
      pos = ((init_index - 1) * 100) * -1;
      el.transformPage(settings, pos, init_index);
      
    }else{
      $(settings.sectionContainer + "[data-index='1']").addClass("active");
      $("body").addClass("viewing-page-1");
      if(settings.pagination == true) $(".onepage-pagination li a" + "[data-index='1']").addClass("active");
    }
    if(settings.pagination == true)  {
      $(".onepage-pagination li a").click(function (){
        var page_index = $(this).data("index");
        if (!$(this).hasClass("active")) {
          current = $(settings.sectionContainer + ".active");
          next = $(settings.sectionContainer + "[data-index='" + (page_index) + "']");
          if(next) {
            current.removeClass("active");
            next.addClass("active");
            $(".onepage-pagination li a" + ".active").removeClass("active");
            $(".onepage-pagination li a" + "[data-index='" + (page_index) + "']").addClass("active");
            $("body")[0].className = $("body")[0].className.replace(/\bviewing-page-\d.*?\b/g, '');
            $("body").addClass("viewing-page-"+next.data("index"));
          }
          pos = ((page_index - 1) * 100) * -1;
          el.transformPage(settings, pos, page_index);
        }
        if (settings.updateURL == false) return false;
      });
    }
    
    
    $(document).bind('mousewheel DOMMouseScroll', function(event) {
      event.preventDefault();
      var delta = event.originalEvent.wheelDelta || -event.originalEvent.detail;
      if(!$("body").hasClass("disabled-onepage-scroll")) init_scroll(event, delta);
    });
    
    
    if(settings.responsiveFallback != false) {
      $(window).resize(function() {
        responsive();
      });
      
      responsive();
    }
    
    if(settings.keyboard == true) {
      $(document).keydown(function(e) {
        var tag = e.target.tagName.toLowerCase();
        
        if (!$("body").hasClass("disabled-onepage-scroll")) {
          switch(e.which) {
            case 38:
              if (tag != 'input' && tag != 'textarea') el.moveUp();
            break;
            case 40:
              if (tag != 'input' && tag != 'textarea') el.moveDown();
            break;
            default: return;
          }
        }
        
        e.preventDefault(); 
      });
    }
    return false;
  };
  
  
}(window.jQuery);


//


//zaccordion
/*
	jQuery zAccordion Plugin v2.1.0
	Copyright (c) 2010 - 2012 Nate Armagost, http://www.armagost.com/zaccordion
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
(function ($) {
	"use strict";
	$.fn.zAccordion = function (method) {
		var defaults = {
			timeout: 6000, /* Time between each slide (in ms). */
			width: null, /* Width of the container. This option is required. */
			slideWidth: null, /* Width of each slide in pixels or width of each slide compared to a 100% container. */
			tabWidth: null, /* Width of each slide's "tab" (when clicked it opens the slide) or width of each tab compared to a 100% container. */
			height: null, /* Height of the container. This option is required. */
			startingSlide: 0, /* Zero-based index of which slide should be displayed. */
			slideClass: null, /* Class prefix of each slide. If left null, no classes will be set. */
			easing: null, /* Easing method. */
			speed: 1200, /* Speed of the slide transition (in ms). */
			auto: true, /* Whether or not the slideshow should play automatically. */
			trigger: "click", /* Event type that will bind to the "tab" (click, mouseover, etc.). */
			pause: true, /* Pause on hover. */
			invert: false, /* Whether or not to invert the slideshow, so the last slide stays in the same position, rather than the first slide. */
			animationStart: function () {}, /* Function called when animation starts. */
			animationComplete: function () {}, /* Function called when animation completes. */
			buildComplete: function () {}, /* Function called after the accordion is finished building. */
			errors: false /* Display zAccordion specific errors. */
		}, helpers = {
			displayError: function (msg, e) {
				if (window.console && e) {
					console.log("zAccordion: " + msg + ".");
				}
			},
			findChildElements: function (t) { /* Function to find the number of child elements. */
				if (t.children().get(0) === undefined) {
					return false;
				} else {
					return true;
				}
			},
			getNext: function (s, c) { /* Returns the 0-index of the next slide. */
				var next = c + 1;
				if (next >= s) {
					next = 0;
				}
				return next;
			},
			fixHeight: function (o) {
				if ((o.height === null) && (o.slideHeight !== undefined)) { /* Removed slideHeight. */
					o.height = o.slideHeight;
					return true;
				} else if ((o.height !== null) && (o.slideHeight === undefined)) {
					return true;
				} else if ((o.height === null) && (o.slideHeight === undefined)) {
					return false;
				}
			},
			getUnits: function (o) {
				if (o !== null) {
					if (o.toString().indexOf("%") > -1) {
						return "%";
					} else if (o.toString().indexOf("px") > -1) {
						return "px";
					} else {
						return "px";
					}
				}
			},
			toInteger: function (o) {
				if (o !== null) {
					return parseInt(o, 10);
				}
			},
			sizeAccordion: function (t, o) { /* Calculate the sizes of the tabs and slides */
				if ((o.width === undefined) && (o.slideWidth === undefined) && (o.tabWidth === undefined)) {
					/* Nothing is defined. */
					helpers.displayError("width must be defined", o.errors);
					return false;
				} else if ((o.width !== undefined) && (o.slideWidth === undefined) && (o.tabWidth === undefined)) {
					/* Only width is defined. */
					/* Check for errors. */
					if ((o.width > 100) && (o.widthUnits === "%")) { /* Check for a width percentage of over 100. */
						helpers.displayError("width cannot be over 100%", o.errors);
						return false;
					} else {
						o.slideWidthUnits = o.widthUnits;
						o.tabWidthUnits = o.widthUnits;
						if (o.widthUnits === "%") { /* Percentages. */
							o.tabWidth = 100 / (t.children().size() + 1); /* Use 100% instead of the defined width. */
							o.slideWidth = 100 - ((t.children().size() - 1) * o.tabWidth);
						} else { /* Pixels. */
							o.tabWidth = o.width / (t.children().size() + 1);
							o.slideWidth = o.width - ((t.children().size() - 1) * o.tabWidth);
						}
						return true;
					}
				} else if ((o.width === undefined) && (o.slideWidth !== undefined) && (o.tabWidth === undefined)) {
					/* Only slideWidth is defined. */
					helpers.displayError("width must be defined", o.errors);
					return false;
				} else if ((o.width === undefined) && (o.slideWidth === undefined) && (o.tabWidth !== undefined)) {
					/* Only tabWidth is defined. */
					helpers.displayError("width must be defined", o.errors);
					return false;
				} else if ((o.width !== undefined) && (o.slideWidth === undefined) && (o.tabWidth !== undefined)) {
					/* width and tabWidth defined. */
					/* Check for errors */
					if (o.widthUnits !== o.tabWidthUnits) {
						helpers.displayError("Units do not match", o.errors);
						return false;
					} else if ((o.width > 100) && (o.widthUnits === "%")) {
						helpers.displayError("width cannot be over 100%", o.errors);
						return false;
					} else if ((((t.children().size() * o.tabWidth) > 100) && (o.widthUnits === "%")) || (((t.children().size() * o.tabWidth) > o.width) && (o.widthUnits === "px"))) {
						helpers.displayError("tabWidth too large for accordion", o.errors);
						return false;
					} else {
						/* Need to define the remaining slideWidth */
						o.slideWidthUnits = o.widthUnits; /* Set the units to be consistent */
						if (o.widthUnits === "%") { /* Percentages */
							o.slideWidth = 100 - ((t.children().size() - 1) * o.tabWidth); /* Use 100% instead of the defined width */
						} else { /* Pixels */
							o.slideWidth = o.width - ((t.children().size() - 1) * o.tabWidth);
						}
						return true;
					}
				} else if ((o.width !== undefined) && (o.slideWidth !== undefined) && (o.tabWidth === undefined)) {
					/* width and slideWidth defined. */
					/* Check for errors. */
					if (o.widthUnits !== o.slideWidthUnits) {
						helpers.displayError("Units do not match", o.errors);
						return false;
					} else if ((o.width > 100) && (o.widthUnits === "%")) {
						helpers.displayError("width cannot be over 100%", o.errors);
						return false;
					} else if (o.slideWidth >= o.width) {
						helpers.displayError("slideWidth cannot be greater than or equal to width", o.errors);
						return false;
					} else if ((((t.children().size() * o.slideWidth) < 100) && (o.widthUnits === "%")) || (((t.children().size() * o.slideWidth) < o.width) && (o.widthUnits === "px"))) { /* Prevents gaps in the accordion. For example, a slider with 4 slides at 150 pixels wide. 4 * 150 = 600. Needs to fill an 800px space. */
						helpers.displayError("slideWidth too small for accordion", o.errors);
						return false;
					} else {
						/* Need to define the remaining tabWidth. */
						o.tabWidthUnits = o.widthUnits; /* Set the units to be consistent. */
						if (o.widthUnits === "%") { /* Percentages. */
							o.tabWidth = (100 - o.slideWidth) / (t.children().size() - 1); /* Use 100% instead of the defined width. */
						} else { /* Pixels. */
							o.tabWidth = (o.width - o.slideWidth) / (t.children().size() - 1);
						}
						return true;
					}
				} else if ((o.width === undefined) && (o.slideWidth !== undefined) && (o.tabWidth !== undefined)) {
					/* slideWidth and tabWidth defined. */
					helpers.displayError("width must be defined", o.errors);
					return false;
				} else if ((o.width !== undefined) && (o.slideWidth !== undefined) && (o.tabWidth !== undefined)) {
					/* width, slideWidth, and tabWidth defined. */
					helpers.displayError("At maximum two of three attributes (width, slideWidth, and tabWidth) should be defined", o.errors);
					return false;
				}
			},
			timer: function (obj) {
				var n = obj.data("next") + 1;
				if (obj.data("pause") && obj.data("inside") && obj.data("auto")) {
					try {
						clearTimeout(obj.data("interval"));
					} catch (e) {}
				} else if (obj.data("pause") && !obj.data("inside") && obj.data("auto")) {
					try {
						clearTimeout(obj.data("interval"));
					} catch (f) {}
					obj.data("interval", setTimeout(function () {
						obj.children(obj.children().get(0).tagName + ":nth-child(" + n + ")").trigger(obj.data("trigger"));
					}, obj.data("timeout")));
				} else if (!obj.data("pause") && obj.data("auto")) {
					try {
						clearTimeout(obj.data("interval"));
					} catch (g) {}
					obj.data("interval", setTimeout(function () {
						obj.children(obj.children().get(0).tagName + ":nth-child(" + n + ")").trigger(obj.data("trigger"));
					}, obj.data("timeout")));
				}
			}
		}, methods = {
			init: function (options) {
				var f, fixattr = ["slideWidth", "tabWidth", "startingSlide", "slideClass", "animationStart", "animationComplete", "buildComplete"];
				for (f = 0; f < fixattr.length; f += 1) {
					if ($(this).data(fixattr[f].toLowerCase()) !== undefined) {
						$(this).data(fixattr[f], $(this).data(fixattr[f].toLowerCase()));
						$(this).removeData(fixattr[f].toLowerCase());
					}
				}
				/* Add new properties to options. */
				options = $.extend(defaults, options, $(this).data());
				/* Check for a height */
				if (this.length <= 0) {
					helpers.displayError("Selector does not exist", options.errors);
					return false;
				} else if (!helpers.fixHeight(options)) {
					helpers.displayError("height must be defined", options.errors);
					return false;
				} else if (!helpers.findChildElements(this)) {
					helpers.displayError("No child elements available", options.errors);
					return false;
				} else if (options.speed > options.timeout) {
					helpers.displayError("Speed cannot be greater than timeout", options.errors);
					return false;
				} else {
					/* Get the correct units */
					options.heightUnits = helpers.getUnits(options.height);
					options.height = helpers.toInteger(options.height);
					options.widthUnits = helpers.getUnits(options.width);
					options.width = helpers.toInteger(options.width);
					options.slideWidthUnits = helpers.getUnits(options.slideWidth);
					options.slideWidth = helpers.toInteger(options.slideWidth);
					options.tabWidthUnits = helpers.getUnits(options.tabWidth);
					options.tabWidth = helpers.toInteger(options.tabWidth);
					if (options.slideClass !== null) {
						options.slideOpenClass = options.slideClass + "-open"; /* Class of open slides. */
						options.slideClosedClass = options.slideClass + "-closed"; /* Class of closed slides. */
						options.slidePreviousClass = options.slideClass + "-previous"; /* Class of the slide that was previously open before a new one was triggered. */
					}
					/* Check for inconsistencies in size. */
					if (!helpers.sizeAccordion(this, options)) {
						return false;
					} else {
						return this.each(function () {
							var o = options, obj = $(this), originals = [], /* inside = false, */ animate, tag, childtag, size, previous = -1; /* o: all of the options (defaults, user options, settings) */
							animate = o.slideWidth - o.tabWidth; /* Number of pixels yet do be displayed on a hidden slide. */
							tag = obj.get(0).tagName; /* Tag type of the container. */
							childtag = obj.children().get(0).tagName; /* Tag type of the children. */
							size = obj.children().size(); /* Number of children. */
							obj.data($.extend({}, {
								auto: o.auto,
								interval: null,
								timeout: o.timeout,
								trigger: o.trigger,
								current: o.startingSlide,
								previous: previous,
								next: helpers.getNext(size, o.startingSlide),
								slideClass: o.slideClass, /* Keeping this around right now only for the sake of the destroy function. */
								inside: false,
								pause: o.pause
							}));
							if (o.heightUnits === "%") {
								o.height = (obj.parent().get(0).tagName === "BODY") ? o.height * 0.01 * $(window).height() : o.height * 0.01 * obj.parent().height();
								o.heightUnits = "px"; /* Need to revert to pixels because CSS 100% height does not cooperate. */
							}
							/* Loop through each of the slides and set the layers. */
							obj.children().each(function (childindex) {
								var zindex, xpos, y;
								xpos = o.invert ? xpos = ((size - 1) * o.tabWidth) - (childindex * o.tabWidth) : childindex * o.tabWidth; /* Used for the position of each slide. */
								originals[childindex] = xpos; /* px position of each open slide. */
								zindex = o.invert ? ((size - 1) - childindex) * 10 : childindex * 10; /* Increase each slide's z-index by 10 so they sit on top of each other. */
								if (o.slideClass !== null) {
									$(this).addClass(o.slideClass); /* Add the slide class to each of the slides. */
								}
								$(this).css({
									"top": 0,
									"z-index": zindex,
									"margin": 0,
									"padding": 0,
									"float": "left",
									"display": "block",
									"position": "absolute",
									"overflow": "hidden",
									"width": o.slideWidth + o.widthUnits,
									"height": o.height + o.heightUnits
								});
								if (childtag === "LI") {
									$(this).css({
										"text-indent": 0
									});
								}
								if (o.invert) {
									$(this).css({ "right": xpos + o.widthUnits, "float": "right" });
								} else {
									$(this).css({ "left": xpos + o.widthUnits, "float": "left" });
								}
								if (childindex === (o.startingSlide)) {
									$(this).css("cursor", "default");
									if (o.slideClass !== null) {
										$(this).addClass(o.slideOpenClass);
									}
								} else {
									$(this).css("cursor", "pointer");
									if (o.slideClass !== null) {
										$(this).addClass(o.slideClosedClass);
									}
									if ((childindex > (o.startingSlide)) && (!o.invert)) {
										y = childindex + 1;
										obj.children(childtag + ":nth-child(" + y + ")").css({
											left: originals[y - 1] + animate + o.widthUnits
										});
									} else if ((childindex < (o.startingSlide)) && (o.invert)) {
										y = childindex + 1;
										obj.children(childtag + ":nth-child(" + y + ")").css({
											right: originals[y - 1] + animate + o.widthUnits
										});
									}
								}
							});
							/* Modify the CSS of the main container. */
							obj.css({
								"display": "block",
								"height": o.height + o.heightUnits,
								"width": o.width + o.widthUnits,
								"padding": 0,
								"position": "relative",
								"overflow": "hidden"
							});
							/* If the container is a list, get rid of any bullets. */
							if ((tag === "UL") || (tag === "OL")) {
								obj.css({
									"list-style": "none"
								});
							}
							obj.hover(function () {
								obj.data("inside", true);
								/* If pause on hover, clear the timer. */
								if (obj.data("pause")) {
									try {
										clearTimeout(obj.data("interval"));
									} catch (e) {}
								}
							}, function () {
								obj.data("inside", false);
								/* Restart the accordion when user moves mouse out of the slides. */
								if (obj.data("auto") && obj.data("pause")) {
									helpers.timer(obj);
								}
							});
							/* Set up the listener to change slides when triggered. */
							obj.children().bind(o.trigger, function () {
								/* Don't do anything if the slide is already open. */
								if ($(this).index() !== obj.data("current")) {
									var i, j, p, c; /* p and c are 1-indexes */
									p = previous + 1; /* Using the 1-index for nth selector. */
									c = obj.data("current") + 1; /* Using the 1-index for nth selector. */
									if ((p !== 0) && (o.slideClass !== null)) {
										obj.children(childtag + ":nth-child(" + p + ")").removeClass(o.slidePreviousClass); /* Remove class for previous slide if previous slide exists. */
									}
									obj.children(childtag + ":nth-child(" + c + ")");
									if (o.slideClass !== null) {
										obj.children(childtag + ":nth-child(" + c + ")").addClass(o.slidePreviousClass);
									}
									previous = obj.data("current");
									obj.data("previous", obj.data("current"));
									p = previous;
									p += 1;
									obj.data("current", $(this).index());
									c = obj.data("current");
									c += 1;
									obj.children().css("cursor", "pointer");
									$(this).css("cursor", "default"); /* Add the open class to the slide tab that was just triggered */
									if (o.slideClass !== null) {
										obj.children().addClass(o.slideClosedClass).removeClass(o.slideOpenClass);
										$(this).addClass(o.slideOpenClass).removeClass(o.slideClosedClass); /* Add the open class to the slide tab that was just triggered */
									}
									obj.data("next", helpers.getNext(size, $(this).index()));
									/* If the slide is not open... */
									helpers.timer(obj);
									o.animationStart();
									if (o.invert) {
										obj.children(childtag + ":nth-child(" + c + ")").stop().animate({avoidCSSTransitions:true, right: originals[obj.data("current")] + o.widthUnits }, o.speed, o.easing, o.animationComplete);
									} else {
										obj.children(childtag + ":nth-child(" + c + ")").stop().animate({avoidCSSTransitions:true, left: originals[obj.data("current")] + o.widthUnits }, o.speed, o.easing, o.animationComplete);
									}
									/* Closing other slides. */
									for (i = 0; i < size; i += 1) {
										j = i + 1;
										if (i < obj.data("current")) {
											if (o.invert) {
												obj.children(childtag + ":nth-child(" + j + ")").stop().animate({avoidCSSTransitions:true,
													right: o.width - (j * o.tabWidth) + o.widthUnits
												}, o.speed, o.easing);
											} else {
												obj.children(childtag + ":nth-child(" + j + ")").stop().animate({avoidCSSTransitions:true,
													left: originals[i] + o.widthUnits
												}, o.speed, o.easing);
											}
										}
										if (i > obj.data("current")) {
											if (o.invert) {
												obj.children(childtag + ":nth-child(" + j + ")").stop().animate({avoidCSSTransitions:true,
													right: (size - j) * o.tabWidth + o.widthUnits
												}, o.speed, o.easing);
											} else {
												obj.children(childtag + ":nth-child(" + j + ")").stop().animate({avoidCSSTransitions:true,
													left: originals[i] + animate + o.widthUnits
												}, o.speed, o.easing);
											}
										}
									}
									return false; /* This is important. If a visible link is clicked within the slide, it will open the slide instead of redirecting the link. */
								}
							});
							/* Set up the original timer. */
							if (obj.data("auto")) {
								helpers.timer(obj);
							}
							o.buildComplete();
						});
					}
				}
			},
			stop: function () { /* This will stop the accordion unless the slides are clicked, however, it will not resume the autoplay. */
				if ($(this).data("auto")) {
					clearTimeout($(this).data("interval"));
					$(this).data("auto", false);
				}
			},
			start: function () { /* This will start the accordion back up if it has been stopped. */
				if (!$(this).data("auto")) {
					var n = $(this).data("next") + 1;
					$(this).data("auto", true);
					$(this).children($(this).children().get(0).tagName + ":nth-child(" + n + ")").trigger($(this).data("trigger"));
				}
			},
			trigger: function (x) {
				if ((x >= $(this).children().size()) || (x < 0)) { /* If the triggered slide is out of range, trigger the first slide. */
					x = 0;
				}
				x += 1; /* Use nth-child to trigger slide. */
				$(this).children($(this).children().get(0).tagName + ":nth-child(" + x + ")").trigger($(this).data("trigger"));
			},
			destroy: function (o) {
				var removestyle, removeclasses, prefix = $(this).data("slideClass");
				if (o !== undefined) {
					removestyle = (o.removeStyleAttr !== undefined) ? o.removeStyleAttr : true;
					removeclasses = (o.removeClasses !== undefined) ? o.removeClasses : false;
				}
				clearTimeout($(this).data("interval"));
				$(this).children().stop().unbind($(this).data("trigger"));
				$(this).unbind("mouseenter mouseleave mouseover mouseout");
				if (removestyle) {
					$(this).removeAttr("style");
					$(this).children().removeAttr("style");
				}
				if (removeclasses) {
					$(this).children().removeClass(prefix);
					$(this).children().removeClass(prefix + "-open");
					$(this).children().removeClass(prefix + "-closed");
					$(this).children().removeClass(prefix + "-previous");
				}
				$(this).removeData();
				if (o !== undefined) {
					if (o.destroyComplete !== "undefined") {
						if (typeof(o.destroyComplete.afterDestroy) !== "undefined") {
							o.destroyComplete.afterDestroy();
						}
						if (o.destroyComplete.rebuild) {
							return methods.init.apply(this, [o.destroyComplete.rebuild]);
						}
					}
				}
			}
		};
		if (methods[method]) {
			return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
		} else if (typeof method === "object" || !method) {
			return methods.init.apply(this, arguments);
		} else {
			$.error("zAccordion: " + method + " does not exist.");
		}
	};
}(jQuery));

