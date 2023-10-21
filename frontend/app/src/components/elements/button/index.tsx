import React from "react"
import style from "./index.module.scss"

interface Props {
}

const Button = ({}: Props) => {
    return (
        <div className={style.content}>
            <button>button</button>
        </div>
    )
}

export default Button
