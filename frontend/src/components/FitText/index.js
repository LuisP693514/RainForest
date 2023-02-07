import './FitText.css'

import React, { useState, useEffect, useRef } from "react";

const FitText = ({ text, maxWidth, idParam }) => {
  const [fontSize, setFontSize] = useState(16);
  const textRef = useRef(null);

  useEffect(() => {
    const textWidth = textRef.current.offsetWidth;
    if (textWidth > maxWidth) {
      setFontSize(fontSize * maxWidth / textWidth);
    }
  }, [text, maxWidth, fontSize]);

  return (
    <div style={{ maxWidth }}>
      <p id={idParam} ref={textRef} style={{ fontSize }}>
        {text}
      </p>
    </div>
  );
};

export default FitText;