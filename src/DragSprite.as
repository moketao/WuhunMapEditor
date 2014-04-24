package
{
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class DragSprite extends Sprite
	{
		public var isDrag:Boolean;
		public static var lastSel:DragSprite;
		public function DragSprite()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoveEvent);
		}
		
		protected function onAdd(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.MOUSE_OVER,onIn);
		}
		
		public function onRemoveEvent(e:Event=null):void
		{
			removeEventListener(MouseEvent.MOUSE_OVER,onIn);
			onOut();
		}
		protected function onIn(event:MouseEvent):void
		{
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			addEventListener(MouseEvent.MOUSE_OUT,onOut);
			addEventListener(MouseEvent.RELEASE_OUTSIDE,onRelease);
		}
		protected function onRelease(event:MouseEvent = null):void
		{
			isDrag = false;
		}		
		protected function onOut(event:MouseEvent = null):void
		{
			isDrag = false;
			removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
			removeEventListener(MouseEvent.MOUSE_OUT,onOut);
			removeEventListener(MouseEvent.RELEASE_OUTSIDE,onRelease);
			removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveEvent);
		}
		
		protected function onMove(e:MouseEvent):void
		{
			if(isDrag){
				if(e.ctrlKey){
					dispatchEvent(new DataEvent("DragParent",true,false,"start"));
					return;
				}
				this.startDrag();
				if(stage)stage.quality = StageQuality.LOW;
			}
		}
		
		protected function onMouseUp(e:MouseEvent):void
		{
			isDrag = false;
			if(e.ctrlKey){
				dispatchEvent(new DataEvent("DragParent",true,false,"end"));
				return;
			}
			this.stopDrag();
			x = int(x);
			y = int(y);
			if(stage)stage.quality = StageQuality.BEST;
		}
		
		protected function onMouseDown(e:MouseEvent):void
		{
			isDrag = true;
			lastSel = this;
		}
	}
}