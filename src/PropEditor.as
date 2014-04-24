package
{
	import com.bit101.components.PushButton;
	import com.bit101.components.VBox;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class PropEditor extends VBox
	{
		private var main:WuhunMapEditor;
		public function PropEditor(main:WuhunMapEditor, xpos:Number=0, ypos:Number=0)
		{
			super(main, xpos, ypos);
			main.stage.addEventListener(KeyboardEvent.KEY_DOWN,onkeydown);
			this.main = main;
			new PushButton(this,0,0,"Top",TopF);
			new PushButton(this,0,0,"Up",UpF);
			new PushButton(this,0,0,"Dn",DnF);
			new PushButton(this,0,0,"Del",DelF);
		}
		
		private function DelF(e:Event=null):void{
			var ob:DragSprite = DragSprite.lastSel;if(!ob) return;if(!ob.parent) return;
			ob.onRemoveEvent();
			ob.parent.removeChild(ob);
		}
		private function TopF(e:Event=null):void{
			var ob:DragSprite = DragSprite.lastSel;if(!ob) return;if(!ob.parent) return;
			ob.parent.addChild(ob);
		}
		
		private function UpF(e:Event=null):void{
			var ob:DragSprite = DragSprite.lastSel;if(!ob) return;if(!ob.parent) return;
			var index:int = ob.parent.getChildIndex(ob);
			if(index+1>=ob.parent.numChildren)return;
			ob.parent.addChildAt(ob,index+1);
		}
		private function DnF(e:Event=null):void{
			var ob:DragSprite = DragSprite.lastSel;if(!ob) return;if(!ob.parent) return;
			var index:int = ob.parent.getChildIndex(ob);
			if(index-1<0)return;
			ob.parent.addChildAt(ob,index-1);
		}
		protected function onkeydown(e:KeyboardEvent):void{
			var ob:DragSprite = DragSprite.lastSel; if(!ob) return; if(!ob.parent) return;
			trace(e.keyCode);
			var add:int = 0;
			if(e.shiftKey) add=9;
			switch(e.keyCode){
				case 37:{
					ob.x -= 1+add;
					break;
				}
				case 39:{
					ob.x += 1+add;
					break;
				}
				case 38:{
					ob.y -= 1+add;
					break;
				}
				case 40:{
					ob.y += 1+add;
					break;
				}
				case 46:{
					DelF();
					break;
				}
				case 34:
				case 219:{
					DnF();
					break;
				}
				case 33:
				case 221:{
					UpF();
					break;
				}
				default:{
					break;
				}
			}
		}
	}
}