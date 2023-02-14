import './FitText.css'

import React, { useState, useEffect, useRef } from "react";

const FitText = ({ text, maxWidth, idParam, font }) => {
  const [fontSize, setFontSize] = useState(font);
  const textRef = useRef(null);

  useEffect(() => {
    const textWidth = textRef.current.offsetWidth;
    if (textWidth > maxWidth) {
      setFontSize(fontSize * maxWidth / textWidth);
    }
  }, [text, maxWidth, fontSize]);

  return (
    <div style={{ maxWidth }} id='containerforTheBox'>
      <p id={idParam} ref={textRef} style={{ fontSize }}>
        {text}
      </p>
    </div>
  );
};

export default FitText;