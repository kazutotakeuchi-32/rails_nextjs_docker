import { ReactNode } from 'react';
import styles from './index.module.scss'

interface Props  {
    children: ReactNode;
}

const Layout = ({children}:Props) => {
    return (
        <div className={styles.content}>
            <header>ヘッダー</header>
            <main>
                {children}
            </main>
            <footer>フッター</footer>
        </div>
    )
}

export default Layout