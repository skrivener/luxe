
import luxe.Color;
import luxe.Input;
import luxe.Screen;

class Main extends luxe.Game {

    var colors:Array<Color>;

    override function config(config:luxe.AppConfig) {

        #if web
        config.window.fullscreen = true;
        #end

        return config;
    }

    override function onwindowsized( e:WindowEvent ) {
        Luxe.camera.viewport = new luxe.Rectangle( 0, 0, e.event.x, e.event.y);
    }

    var r = 8.0;
    override function ready() {

        Luxe.renderer.clear_color.rgb(0x121212);
        r = Luxe.screen.h * 0.01;

        colors = [
            new Color().rgb(0xf6007b),
            new Color().rgb(0x007bf6),
            new Color().rgb(0xe2f44d),
            new Color().rgb(0xf94b04),
            new Color().rgb(0xf67b00),
            new Color().rgb(0xffffff),
        ];

    } //ready

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    } //onkeyup

    override function ontouchdown(e:TouchEvent) {

        Luxe.renderer.clear_color.tween(0.5, {r:0.1, g:0.1, b:0.1});

        var g = Luxe.draw.ring({
            r:r,
            color:colors[e.touch_id].clone(),
            x:e.x * Luxe.screen.w,
            y:e.y * Luxe.screen.h,
        });

        Luxe.timer.schedule(2, function(){ g.color.tween(1, {a:0}).onComplete(function(){ g.drop(); }); });

    }

    override function ontouchup(e:TouchEvent) {

        Luxe.renderer.clear_color.tween(0.5, {r:0.05, g:0.05, b:0.05});

        var g = Luxe.draw.ring({
            r:r,
            color: colors[e.touch_id].clone(),
            x:e.x * Luxe.screen.w,
            y:e.y * Luxe.screen.h,
        });

        Luxe.timer.schedule(2, function(){ g.color.tween(1, {a:0}).onComplete(function(){ g.drop(); }); });

    }

    override function ontouchmove(e:TouchEvent) {

        var g = Luxe.draw.ring({
            r:r/2,
            color: colors[e.touch_id].clone(),
            x:e.x * Luxe.screen.w,
            y:e.y * Luxe.screen.h,
        });

        Luxe.timer.schedule(2, function(){ g.color.tween(1, {a:0}).onComplete(function(){ g.drop(); }); });

    }

} //Main
