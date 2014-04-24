package
{
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class DropFileArea extends Sprite
	{
		public var txt:TextField;
		private var out:Number = .7;
		public function DropFileArea(w:int=80,h:int=80,_txt:TextField=null):void{
			txt = _txt;
			if(txt==null){
				txt = new TextField();
				var f:TextFormat = new TextFormat();
				f.font = "Consolas";
				txt.defaultTextFormat = f;
				txt.width = w;
				txt.height = h;
				addChild(txt);
			}
			graphics.beginFill(0x333333,1);
			graphics.drawRect(0,0,w,h);
			graphics.endFill();
			addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, doDragEnter);
			addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, doDragDrop);
			addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, doDragExit);
			alpha = out;
		}
		private function doDragEnter(e:NativeDragEvent):void
		{
			NativeDragManager.acceptDragDrop(this);
			alpha = 1;
		}
		private function doDragDrop(e:NativeDragEvent):void
		{
			alpha = out;
			if(!txt) return;
			var dropFiles:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			
			for each (var file:File in dropFiles){
				switch (file.extension){
					case "png" :
						txt.text = file.nativePath;
						break;
					case "jpg" :
						txt.text = file.nativePath;
						break;
					case "atf" :
						txt.text = file.nativePath;
						break;
					default:
						txt.text = "Not a recognised file format";
				}
				dispatchEvent(new DataEvent("DragFile",true,false,file.nativePath));
			}
		}
		private function doDragExit(e:NativeDragEvent):void
		{
			alpha = out;
		}
	}
}