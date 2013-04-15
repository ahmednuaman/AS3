package com.firestartermedia.lib.as3.display.shape
{
    import flash.display.Shape;
    
    public class Rectangle extends Shape
    {
        public function Rectangle(width:Number=1, height:Number=1, bgColour:uint=0xFF6600, borderColour:uint=0x000099, borderThickness:Number=1)
        {
            super();
            
            draw( width, height, bgColour, borderColour, borderThickness );
        }
        
        public function draw(width:Number, height:Number, bgColour:uint, borderColour:uint, borderThickness:Number):void
        {
            graphics.clear();
            graphics.beginFill( bgColour );
            
            if (borderThickness)
            {
                graphics.lineStyle( borderThickness, borderColour );
            }
            
            graphics.moveTo(0, 0);
            graphics.lineTo(width, 0);
            graphics.lineTo(width, height);
            graphics.lineTo(0, height);
            graphics.lineTo(0, 0);
            graphics.endFill();
        }
    }
}