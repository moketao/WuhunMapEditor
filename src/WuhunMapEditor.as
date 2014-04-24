package
{
	import com.bit101.components.HBox;
	import com.bit101.components.InputText;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.VBox;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import loading.Res;

	[SWF(width="1500",height="800",frameRate="30")]
	public class WuhunMapEditor extends Sprite
	{
		private var dropArea:Sprite;
		private var LocalDir:InputText;
		private var LocalUrl:InputText;
		private var res:Res;
		private var dropFileArea:DropFileArea;
		private var inserPicUrl:String;

		private var container:Sprite;

		private var propEditor:PropEditor;
		public function WuhunMapEditor()
		{
			res = new Res();
			Style.embedFonts = false;
			Style.fontName = "Consolas";
			Style.fontSize = 12;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener("DragParent",onDragAll);
			
			dropFileArea = new DropFileArea(stage.stageWidth,18);
				bind(dropFileArea.txt,"DropFile");
				addChild(dropFileArea);
				addEventListener("DragFile",onDragFile);
			var body:VBox = new VBox(this,2,20);
			propEditor = new PropEditor(this,1200,20);
			
			var menu:HBox = new HBox(body);
			container = new Sprite();
			body.addChild(container);
			var btInserPic:PushButton = new PushButton(menu,0,0,"InserPic",InserPic);
			LocalDir = new InputText(menu);
				LocalDir.width = 300;
				LocalDir.height = 20;
			var btSetLocalDir:PushButton = new PushButton(menu,0,0,"SetLocalDir",SetLocalDir);
			LocalUrl = new InputText(menu);
				LocalUrl.width = 300;
				LocalUrl.height = 20;
			var btSetLocalUrl:PushButton = new PushButton(menu,0,0,"SetLocalUrl",SetLocalUrl);
			SetLocalDir();
			SetLocalUrl();
		}
		
		protected function onDragAll(e:DataEvent):void{
			if(e.data=="start"){
				this.startDrag();
			}else{
				this.stopDrag();
			}
		}
		
		protected function onDragFile(e:DataEvent):void{
			bind(dropFileArea.txt,"DropFile");
		}
		
		private function InserPic(e:MouseEvent=null):void{
			var path:String = dropFileArea.txt.text;
			if(path=="") return;
			inserPicUrl = LocalUrl.text + path.replace(LocalDir.text,"");
			res.load("test",[inserPicUrl],onPicLoaded);
		}
		
		private function onPicLoaded():void{
			var bmp:Bitmap = res.loader.getBitmap(inserPicUrl);
			var bmp_clone:Bitmap = new Bitmap(bmp.bitmapData);
			var pic:Pic = new Pic(bmp_clone);
			container.addChild(pic);
		}
		private function SetLocalDir(e:MouseEvent=null):void{
			bind(LocalDir,"LocalDir");
		}
		private function SetLocalUrl(e:MouseEvent=null):void{
			bind(LocalUrl,"LocalUrl");
		}
		public static function bind(input:*,key:String):void{
			var s:SharedObject = SharedObject.getLocal(key);
			if(input.text==""){
				if(s.data[key])input.text = s.data[key];
				return;
			}
			s.data[key] = input.text;
		}
	}
}